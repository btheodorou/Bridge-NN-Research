# If your compiler name is not given here, change it.
CC		= g++

CC_FLAGS	= -O3 -flto -fopenmp

# These flags are not turned on by default, but DDS should pass them.
# Turn them on below.
WARN_FLAGS	= 		\
	-Wshadow 		\
	-Wsign-conversion 	\
	-pedantic -Wall -Wextra  \
	-Wcast-align -Wcast-qual \
	-Wctor-dtor-privacy 	\
	-Wdisabled-optimization \
	-Winit-self 		\
	-Wlogical-op		\
	-Wmissing-declarations 	\
	-Wmissing-include-dirs 	\
	-Wnoexcept 		\
	-Wold-style-cast 	\
	-Woverloaded-virtual 	\
	-Wredundant-decls 	\
	-Wsign-promo 		\
	-Wstrict-null-sentinel	\
	-Werror                 \
	-Wstrict-overflow=1 	\
	-Wswitch-default -Wundef \
	-Wno-unused 		\
	-Wno-unknown-pragmas 	\
	-Wno-long-long		\
	-Wno-format

# Here you can turn on warnings.
# CC_FULL_FLAGS	= $(CC_FLAGS)
CC_FULL_FLAGS	= $(CC_FLAGS)

DLLBASE		= dds
STATIC_LIB	= lib$(DLLBASE).a

ALL_EXAMPLE_FILES	=	\
	DDSolver.cpp

LIB_FLAGS	= -L. -l$(DLLBASE)

LD_FLAGS	= 

OBJ_FILES	= $(subst .cpp,.o,)
EX_OBJ_FILES	= $(subst .cpp,.o,$(ALL_EXAMPLE_FILES))
EX_EXE_FILES	= $(subst .cpp,,$(ALL_EXAMPLE_FILES))

DDSolver:	$(OBJ_FILES) DDSolver.o
	$(CC) $(CC_FULL_FLAGS) $(LD_FLAGS) $(OBJ_FILES) DDSolver.o $(LIB_FLAGS) -o DDSolver

%.o:	%.cpp
	$(CC) $(CC_FULL_FLAGS) -c $< -o $*.o

clean:
	rm -f $(OBJ_FILES) $(EX_OBJ_FILES) $(EX_EXE_FILES) $(STATIC_LIB)
