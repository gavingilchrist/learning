from setuptools import setup
from Cython.Build import cythonize
import Cython.Compiler.Options
import numpy as np

Cython.Compiler.Options.annotate = True

setup(
    ext_modules = cythonize(
        'cython_example.pyx', 
        compiler_directives={'language_level': '3'},
        annotate=True
    ),
    include_dirs=[np.get_include()]
)
