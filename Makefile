# $Id: Makefile,v 1.6 2015-02-26 15:43:49-08 - - $
#Robert Ho rokho@ucsc.edu
#Daniel Urrutia deurruti@ucsc.edu
GPP        = g++ -g -O0 -Wall -Wextra -std=gnu++11

DEPFILE    = Makefile.dep
HEADERS    = sockets.h signal_action.h cix_protocol.h logstream.h
CPPLIBS    = sockets.cpp signal_action.cpp cix_protocol.cpp 
CPPSRCS    = ${CPPLIBS} cix-daemon.cpp cix-client.cpp cix-server.cpp
LIBOBJS    = ${CPPLIBS:.cpp=.o}
CLIENTOBJS = cix-client.o ${LIBOBJS}
SERVEROBJS = cix-server.o ${LIBOBJS}
DAEMONOBJS = cix-daemon.o ${LIBOBJS}
OBJECTS    = ${CLIENTOBJS} ${SERVEROBJS} ${DAEMONOBJS}
EXECBINS   = cix-client cix-server cix-daemon
LISTING    = Listing.ps
SOURCES    = ${HEADERS} ${CPPSRCS} Makefile README PARTNER

all: ${DEPFILE} ${EXECBINS}

cix-client: ${CLIENTOBJS}
	${GPP} -o $@ ${CLIENTOBJS}

cix-server: ${SERVEROBJS}
	${GPP} -o $@ ${SERVEROBJS}

cix-daemon: ${DAEMONOBJS}
	${GPP} -o $@ ${DAEMONOBJS}

%.o: %.cpp
	${GPP} -c $<

ci:
	- checksource ${SOURCES}
	- cid + ${SOURCES}
submit: ${SOURCES}
	- checksource ${SOURCES}
	submit cmps109-wm.w15 asg5 ${SOURCES}

lis: all ${SOURCES} ${DEPFILE}
	mkpspdf ${LISTING} ${SOURCES} ${DEPFILE}

clean:
	- rm ${LISTING} ${LISTING:.ps=.pdf} ${OBJECTS} Makefile.dep

spotless: clean
	- rm ${EXECBINS}

dep:
	- rm ${DEPFILE}
	make --no-print-directory ${DEPFILE}

${DEPFILE}:
	${GPP} -MM ${CPPSRCS} >${DEPFILE}

again: ${SOURCES}
	make --no-print-directory spotless ci all lis

include ${DEPFILE}

