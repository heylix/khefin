#ifndef fido2hmacsecret_invocation_H
#define fido2hmacsecret_invocation_H

#include <stdbool.h>

#ifndef LONGEST_VALID_PASSPHRASE
#define LONGEST_VALID_PASSPHRASE 1024
#endif

#define NL_CHARACTER_TO_STRIP 0x0a

typedef enum subcommand_t {
	unknown,
	help,
	version,
	enrol,
	generate,
	enumerate,
} subcommand_t;

typedef struct invocation_state_t {
	subcommand_t subcommand;
	char *device;
	char *file;
	char *passphrase;
	bool obfuscate_device_info;
} invocation_state_t;

invocation_state_t *parse_arguments_and_get_passphrase(int argc, char **argv);

#endif
