from setuptools import setup

setup(
    name="venv-manager",
    version="0.1.0",
    description="Manage Python virtual environments",
    long_description="Manage Python virtual environments",
    url="https://github.com/luke-saunders/venv-manager",
    author="Luke Saunders",
    author_email="none@no_email_address.com",
    license="GNU General Public License v3",
    scripts=['venv_create.ps1', 'venv_activate.ps1'],
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3.11",
    ],
)