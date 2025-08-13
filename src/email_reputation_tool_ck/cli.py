"""Console script for email_reputation_tool_ck."""

import typer
from rich.console import Console

from email_reputation_tool_ck import utils

app = typer.Typer()
console = Console()


@app.command()
def main():
    """Console script for email_reputation_tool_ck."""
    console.print("Replace this message by putting your code into "
               "email_reputation_tool_ck.cli.main")
    console.print("See Typer documentation at https://typer.tiangolo.com/")
    utils.do_something_useful()


if __name__ == "__main__":
    app()
