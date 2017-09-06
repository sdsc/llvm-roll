# SDSC "llvm" roll

## Overview

This roll bundles llvm

For more information about the various packages included in the llvm roll please visit their official web pages:


- <a href="http://llvm.org" target="_blank">llvm</a> is a collection of modular and reusable compiler and toolchain technologies.
## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate llvm source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler and python
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.


## Building

To build the llvm-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `llvm-*.disk1.iso`.  If you built
the roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building for different python installations.  The
`ROLLPY` make variable can be used to specify the name of the python modulefile
to use for building the software, e.g.,

```shell
make ROLLPY=opt-python 2>&1 | tee build.log
```

Any python modulefile name may be used as the value of the ROLLPY variable.
The default value is "python".


## Installation

To install, first execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll llvm
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents of
the llvm-roll.

To avoid cluttering the cluster frontend with unused software, the llvm-roll is
configured to install only on compute and login nodes. To force installation on
your frontend, run this command after adding the llvm-roll to your distro

```shell
% rocks run roll llvm host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs llvm environment
module files in:

```shell
/opt/modulefiles/compilers/llvm
```


## Testing

The llvm-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/llvm.t 
```

