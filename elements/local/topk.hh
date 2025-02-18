#ifndef CLICK_TOPK_HH
#define CLICK_TOPK_HH
#include <click/batchelement.hh>
CLICK_DECLS

class TopK : public BatchElement {
  public:
    TopK() CLICK_COLD;
    ~TopK() CLICK_COLD;

    const char *class_name() const  { return "TopK"; }
    /* Detailed doc for port_count here: 
    https://pdos.csail.mit.edu/pipermail/click/2005-September/004251.html */
    const char *port_count() const  { return PORTS_1_1; }

    inline Packet *simple_action(Packet *);
};
#endif