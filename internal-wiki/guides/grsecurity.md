# grsecurity

## Introduction
grsecurity is a set of patches for the vanilla Linux kernel which emphasizes security enhancements. They protect the kernel against certain exploits and also provide some additional functionalities, e.g. better access control, better chroots, and various other stuff.

A major component bundled with grsecurity is PaX, which is a patch that, amongst other things, flags data memory, such as that on the stack, as non-executable, and program memory as non-writable. The aim is to prevent executable memory pages from being overwritten with injected machine code, which prevents exploitation of many types of security vulnerabilities, such as buffer overflows. PaX also provides address space layout randomization (ASLR), which randomizes important memory addresses to hinder attacks that rely on such addresses being easily known. PaX is not itself developed by the grsecurity developers, and is also available independently from grsecurity.

## Use in the Competition
A grsecurity-hardened kernel is nice to have because it mitigates some kernel vulnerabilities that can possibly be used for privilege escalation and it also makes other applications harder to exploit. Usually this is good enough to prevent exploitation through the standard metasploit modules. We will not be able to make use of all the additional features grsecurity provides because it would need too much time to configure.

## Installation
grsecurity is a set of patches for the vanilla Linux kernel. Hence the usual installation process would be to get the linux sources, apply the patches and compile. This is of course not reasonable to do in the competition. However there are some packages available for some distributions.

### Debian
There are official Debian packages for the grsecurity kernel patches available: linux-patch-grsecurity2

Note that these are not configurable as to security/performance and overhead, as it's usually done with manually building grsec/PaX support for the Linux kernel.

Add the unstable repositories to your apt sources.list and install via:
`apt-get install -t unstable linux-grsec`
