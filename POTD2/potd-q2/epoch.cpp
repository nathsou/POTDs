#include "epoch.h"

int hours(time_t secs) {
    return secs / 3600;
}

int days(time_t secs) {
    return secs / (24 * 3600);
}

int years(time_t secs) {
    return secs / (365 * 24 * 3600);
}