#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "../include/ansi_color.h"

#ifdef _WIN32
    #include <direct.h>
    #include <io.h>
    #define MKDIR(path) _mkdir(path)
    #define ACCESS(path) _access(path, 0)
#else
    #include <sys/stat.h>
    #include <sys/types.h>
    #include <unistd.h>
    #define MKDIR(path) mkdir(path, 0777)
    #define ACCESS(path) access(path, F_OK)
#endif

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "\n" RED "Error: No folders specified." WHITE "\n");
        fprintf(stderr, "Usage: mmkdir <folder1> <folder2> ...\n\n");
        return 1;
    }

    printf("=> " BOLD_GREEN "Executing..." WHITE "\n");

    for (int i = 1; i < argc; i++) {
        char *folder = argv[i];

        if (ACCESS(folder) == 0) {
            printf("=> " YELLOW "Folder already exists:" WHITE " %s\n", folder);
            continue;
        }

        if (MKDIR(folder) == -1) {
            fprintf(stderr, "=> " RED "Failed to create" WHITE " %s: %s\n", folder, strerror(errno));
            continue;
        }

        printf("=> " GREEN "Created:" WHITE " %s\n", folder);
    }

    printf("\n" BOLD_WHITE "Program executed successfully!" WHITE "\n");
    return 0;
}
