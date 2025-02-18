/*
 *
 * Author: Yixi Chen <yixi.chen@kaust.edu.sa>
 */

// Define the name of ports
define( $dev0   0,
        $dev1   1,
        $print  false,
        $queueSize  1024,
        $burst  32,
)

// Module's I/O
// `BURST` limits the maximum ingress/egress packet in one time
in0 :: FromDPDKDevice($dev0, BURST $burst)
out0 :: ToDPDKDevice($dev0, IQUEUE $queueSize, BURST $burst)

in1 :: FromDPDKDevice($dev1, BURST $burst)
out1 :: ToDPDKDevice($dev1, IQUEUE $queueSize, BURST $burst)

toh :: ToHost();

// TODO: append to handle other types like ARP
eth_filter :: Classifier(12/0800, -);
// TODO: append to handle other types like UDP
ip_filter :: IPClassifier(proto tcp, -);
// Magic number comes from: 20(TCP header len)
offrac_filter :: Classifier(20/0000, 20/0001, 20/0002, 20/0003, -);

// OffRAC operands
topk_op :: TopK();


in0 -> eth_filter;

eth_filter[0] -> Strip(14) -> CheckIPHeader -> ip_filter;
eth_filter[1] -> toh;

ip_filter[0] -> offrac_filter;
ip_filter[1] -> Discard;

// TODO: impl echo
offrac_filter[0] -> Discard;
offrac_filter[1] -> topk_op;
// TODO: impl Logit
offrac_filter[2] -> Discard;
// TODO: impl Min-Max
offrac_filter[3] -> Discard;
