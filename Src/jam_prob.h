struct receiver_options
{
    char *sender_ip;
    char *receiver_port;
    char *packet_size;
    char *duration_in_sec;
    char *avg_prob_rate;
    char *highest_prob_rate;
    char *lowest_prob_rate;
    char *num_estimates_data_points;
    char *decrease_factor;
    char *busy_period_length;
    char *spread_factor;
    char *increment_of_ttl_btw_chrips
};

typedef struct receiver_options Receiver_options;

extern void start_receiver(Receiver_options options);
extern void start_sender(char *self_port);