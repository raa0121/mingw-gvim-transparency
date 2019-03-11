include $(SRCDIR)/Filelist

install: $(RT_ALL) $(RT_ALL_BIN) $(RT_SCRIPTS) $(RT_UNIX_DOS_BIN) $(RT_DOS_BIN)
	@for file in $(?); do install -D $$file $(DISTDIR)/$$file; done
