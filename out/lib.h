#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>


typedef void (*FfiCallback)(uint64_t task_id, uint8_t *ptr, size_t len);

void free_message(uint8_t *ptr, size_t len);

void get_settings(uint64_t task_id, FfiCallback callback);

void initialize(uint64_t task_id, FfiCallback callback, const uint8_t *ptr, size_t len);

void scan(uint64_t task_id, FfiCallback callback);

void should_show_whats_new(uint64_t task_id, FfiCallback callback, const uint8_t *ptr, size_t len);

void stop_scan(uint64_t task_id, FfiCallback callback);

void update_last_seen_version(uint64_t task_id,
                              FfiCallback callback,
                              const uint8_t *ptr,
                              size_t len);

void update_settings(uint64_t task_id, FfiCallback callback, const uint8_t *ptr, size_t len);
