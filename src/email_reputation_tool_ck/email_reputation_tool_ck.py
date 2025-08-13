import os
import subprocess

"""Main module."""
def install_package(package_name):
    """Install a Python package using pip."""
    try:
        subprocess.check_call([os.sys.executable, "-m", "pip", "install", package_name])
        print(f"Package '{package_name}' installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to install package '{package_name}'. Error: {e}")

# Example usage
if __name__ == "__main__":
    package_to_install = "emailrep"
    install_package(package_to_install)