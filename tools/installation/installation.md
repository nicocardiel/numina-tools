# Installing numina

As the scripts described on this webpage are occasionally modified to improve
their performance, we recommend installing the latest version of **numina** to
ensure compatibility and access to the most up-to-date features.

In order to keep your current Python installation clean, it is highly
recommended to install a Python 3 *virtual environment* as a first step.

## Creating and activating a python virtual environment

The following describes two different ways to generate a Python environment:
`venv` and `conda`.

### Using `venv`

Suppose we want to generate a virtual environment that hangs directly from the
user's root directory. In that case, we must execute the following
instructions:

```{code-block} console
:class: no-copybutton

$ cd
$ python3 -m venv venv_numina
```

Note that the above process generates a folder called `venv_numina` just
below the root directory. It is also possible to specify an alternative path
and name to generate the desired environment. It is important to remember the
location and name of this directory if we later need to remove the environment
from the system.

To activate the environment:

```{code-block} console
:class: no-copybutton

$ . venv_numina/bin/activate
(venv_numina) $
```

From now on, the prompt

```{code-block} console
:class: no-copybutton

(venv_numina) $
```

will indicate that we are working in this specific environment.

To stop using this environment, we only need to execute the following command:

```{code-block} console
:class: no-copybutton

(venv_numina) $ deactivate
$
```

For more information on the use of virtual environments, it is advisable to
consult the [venv documentation](https://docs.python.org/3/library/venv.html).

### Using `conda`

Conda users can also easily generate Python environments. It is also possible
to specify a particular Python version, e.g.:

```{code-block} console
:class: no-copybutton

(base) $ conda create --name venv_numina python=3.13
```

To activate the new environment:

```{code-block} console
:class: no-copybutton

(base) $ conda activate venv_numina
(venv_numina) $
```

From now on, the prompt

```{code-block} console
:class: no-copybutton

(venv_numina) $
```

will indicate that we are working in this specific environment.

To stop using this environment, we only need to execute the following command:

```{code-block} console
:class: no-copybutton

(venv_numina) $ conda deactivate
(base) $
```

For more information on the use of conda virtual environments, please consult
[this link](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

## Installing the software

After activating the Python enviroment, **numina** can be easily installed with
`pip`, a standard Python tool for package management. It should download the
package and its dependencies, unpack everything and compile when needed.

```console
(venv_numina) $ pip install numina
```

Since the *numina* package may contain recent changes that are not in,
it is advisable to install its development version

```console
(venv_numina) $ pip install git+https://github.com/guaix-ucm/numina.git@main#egg=numina
```

If, for any reason, the standard installation of the package provides
functionality that differs from what is described here, it is possible that
recent changes have been introduced which have not yet been incorporated into
the release available via pip. In such cases, it is recommended to install the
development version of the code directly from its GitHub repository.

## Uninstalling the software

If the software has been installed in an environment as described above using
`venv`, its removal from the system is very simple. It is only necessary to
disable the environment and delete the directory in which the environment has
been generated.

```{code-block} console
:class: no-copybutton

(venv_numina) $ deactivate
$ cd
$ rm -fr venv_numina
```

If the software was installed using `conda`, you can remove the environment
using:

```{code-block} console
:class: no-copybutton

(venv_numina) $ conda deactivate
(base) $ conda remove --name venv_numina --all
```
