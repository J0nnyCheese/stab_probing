#include "jam_prob.h"
#include <stdio.h>
#include <stdlib.h>

void start_receiver(Receiver_options options)
{
    int argc = 0;
    char *argv[40] = {0};
    argv[0] = "stab_rcv";

    if (options.sender_ip == NULL) {
        fprintf(stderr, "Sender IP is not provided.");
        exit(-1);
    }
    argc ++;
    argv[1] = options.sender_ip;

    // if (receiver_port != NULL) {

    // }
}