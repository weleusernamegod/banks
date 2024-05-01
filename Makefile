ifndef GBDK_HOME
	GBDK_HOME = /usr/local/opt/gbdk/
endif

LCC = $(GBDK_HOME)bin/lcc

LCCFLAGS = -debug -Wl-yt0x1B -Wm-yo4 -Wm-ya4 # Set an MBC for banking (1B-ROM+MBC5+RAM+BATT)

PROJECTNAME = banks
SRCDIR      = src
OBJDIR      = obj/$(EXT)
BINDIR      = build/$(EXT)
MKDIRS      = $(OBJDIR) $(BINDIR) # See bottom of Makefile for directory auto-creation

BINS	    = $(OBJDIR)/$(PROJECTNAME).$(EXT)
CSOURCES    = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c)))
OBJS        = $(CSOURCES:%.c=$(OBJDIR)/%.o)

all:	clean prepare $(BINS) copy-rom

# Compile .c files in "src/" to .o object files with specific flags for bank files
$(OBJDIR)/%.o:	$(SRCDIR)/%.c
	@# Determine specific flags based on file name
	$(eval EXTRA_FLAGS :=)
	$(if $(findstring bank.ba0,$<), $(eval EXTRA_FLAGS := -Wf-ba0))
	$(if $(findstring bank.ba1,$<), $(eval EXTRA_FLAGS := -Wf-ba1))

	@# Compile with possible additional flags
	$(LCC) $(LCCFLAGS) $(EXTRA_FLAGS) -c -o $@ $<

# Link the compiled object files into a .gb ROM file
$(BINS):	$(OBJS)
	$(LCC) $(LCCFLAGS) -o $(BINDIR)/$(PROJECTNAME).gb $(OBJS)

prepare:
	mkdir -p $(MKDIRS) $(OBJDIR) $(BINDIR)

clean:
	rm -f  $(OBJDIR)/*.* $(BINDIR)/*.*

copy-rom:
	cp $(BINDIR)/$(PROJECTNAME).gb .

$(info $(shell mkdir -p $(MKDIRS)))
