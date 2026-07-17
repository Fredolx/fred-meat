#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>


typedef void (*FfiCallback)(uint64_t task_id, uint8_t *ptr, size_t len);

void free_message(uint8_t *ptr, size_t len);

void initialize(uint64_t task_id, FfiCallback callback, const uint8_t *ptr, size_t len);
