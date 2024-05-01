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
OBJS        = $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

all:	clean prepare $(BINS)

# Compile .c files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

# Link the compiled object files into a .gb ROM file
$(BINS):	$(OBJS)
	$(LCC) $(LCCFLAGS) -o $(BINDIR)/$(PROJECTNAME).gb $(OBJS)

prepare:
	mkdir -p $(OBJDIR)

clean:
	rm -f  $(OBJDIR)/*.* $(BINDIR)/*.*

$(info $(shell mkdir -p $(MKDIRS)))
