# Python Virtual Environment Manager

---

Create one (or more) requirements.txt files in the project.  Requirements files can be located anywhere in the project folder structure, however, at least one must be placed in the project root folder.

### Installation

pip install git+https://github.com/luke-saunders/venv-manager.git

### Create or Update Virtual Environment

    PS> venv_create.ps1 [-venv_name] [-requirements]

Default parameters:

    venv_name       venv
    requirements    requirements*.txt

### Activate Virtual Environment

    PS> venv_activate.ps1

---

###### References
- https://pip.pypa.io/en/latest/user_guide/#requirements-files

