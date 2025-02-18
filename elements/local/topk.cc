// -*- c-basic-offset: 4 -*-
/*
 *
 *
 */

#include <click/config.h>
#include "topk.hh"
CLICK_DECLS

TopK::TopK()
{
}

TopK::~TopK()
{
}

Packet *
TopK::simple_action(Packet *p)
{
    return p;
}

CLICK_ENDDECLS
EXPORT_ELEMENT(TopK)
