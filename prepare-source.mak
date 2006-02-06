gen: configure config.h.in proto man

configure: configure.in aclocal.m4
	autoconf

config.h.in: configure.in aclocal.m4
	autoheader

proto:
	cat *.c lib/compat.c | awk -f mkproto.awk >proto.h.new
	if diff proto.h proto.h.new >/dev/null; then \
	  rm proto.h.new; \
	else \
	  mv proto.h.new proto.h; \
	fi

man: rsync.1 rsyncd.conf.5

rsync.1: rsync.yo
	yodl2man -o rsync.1 rsync.yo

rsyncd.conf.5: rsyncd.conf.yo
	yodl2man -o rsyncd.conf.5 rsyncd.conf.yo
