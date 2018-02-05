import unittest
import boto3
import requests
import socket
import warnings

from requests.packages.urllib3.exceptions import InsecureRequestWarning

def get_elb_dns_record():
    '''
    Returns the DNS record/URL for the AWS loadbalancer for use in other tests
    '''
    client = boto3.client('elb')
    load_balancer_data = client.describe_load_balancers(LoadBalancerNames=['webserver-elb'])
    dns_name = load_balancer_data['LoadBalancerDescriptions'][0]['DNSName']

    return dns_name


class WebserverTest(unittest.TestCase):

    def setUp(self):
        ''' 
        Setup tasks to suppress connection and SSL warnings coming from boto and requests respectively
        '''
        warnings.simplefilter("ignore", ResourceWarning)
        requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

    def test_port_80(self):
        url = get_elb_dns_record()
        r = requests.get("http://{0}".format(url), allow_redirects=False)
        self.assertEqual(r.status_code, 301)

    def test_port_80_redirects_to_https(self):
        url = get_elb_dns_record()
        r = requests.get("http://{0}".format(url), allow_redirects=False)
        self.assertEqual(r.headers['Location'], "https://{0}/".format(url))

    def test_redirected_page_returns_expected_content(self):
        url = get_elb_dns_record()
        r = requests.get("https://{0}".format(url), allow_redirects=False, verify=False)
        assert "<h1>Hello World</h1>" in r.text

    def test_only_80_and_443_open_on_elb(self):
        client = boto3.client('elb')
        elb_data = client.describe_load_balancers(LoadBalancerNames=['webserver-elb'])
        listeners = elb_data['LoadBalancerDescriptions'][0]['ListenerDescriptions']
        ports = set()
        for listener in listeners:
            ports.add(listener['Listener']['LoadBalancerPort'])
            ports.add(listener['Listener']['InstancePort'])
        sorted_ports = sorted(ports)
        self.assertEqual(sorted_ports, [80,443])


if __name__=='__main__':
    unittest.main()

