#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include "../include/ansi_color.h"

#ifdef _WIN32
    #include <io.h>
    #define CLOSE _close
    #define OPEN(path, flags, mode) _open(path, flags, mode)
#else
    #include <unistd.h>
    #define CLOSE close
    #define OPEN(path, flags, mode) open(path, flags, mode)
#endif

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "\n" RED "Error: No files specified." WHITE "\n");
        fprintf(stderr, "Usage: touch <file1> <file2> ...\n\n");
        return 1;
    }

    printf(WHITE "\n=> " BOLD_GREEN "Executing..." WHITE "\n");

    for (int i = 1; i < argc; i++) {
        char *filename = argv[i];
        
        // Open with O_CREAT to create if doesn't exist, O_WRONLY to write (minimal access)
        // Mode 0644 for Unix: rw-r--r--
        // For Windows _S_IREAD | _S_IWRITE would be more correct, but 0644 works for simple cases.
        int fd = OPEN(filename, O_CREAT | O_WRONLY, 0644);
        
        if (fd == -1) {
            fprintf(stderr, "=> " RED "Error creating" WHITE " %s: %s\n", filename, strerror(errno));
            continue;
        }

        CLOSE(fd);
        printf(WHITE "=> " GREEN "Created/Updated:" WHITE " %s\n", filename);
    }

    printf("\n" BOLD_WHITE "Program executed successfully!" WHITE "\n");
    return 0;
}
