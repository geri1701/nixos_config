"""
title: File System Operations
author: charettep
author_url: https://charettep.com
version: 1.0.0
license: MIT
description: A tool for reading, writing, and managing files on the local system.
requirements: pydantic
"""

import os
import json
from typing import Optional
from pydantic import BaseModel, Field


class Tools:
    class Valves(BaseModel):
        """Configuration for file system tool"""

        allowed_paths: list[str] = Field(
            default=["/home/geri"],
            description="List of allowed directory paths for file operations",
        )
        max_file_size: int = Field(
            default=10485760,
            description="Maximum file size in bytes for read/write operations",
        )

    def __init__(self):
        self.valves = self.Valves()

    def _is_path_allowed(self, path: str) -> bool:
        """Check if path is within allowed directories"""
        abs_path = os.path.abspath(path)
        return any(
            abs_path.startswith(allowed) for allowed in self.valves.allowed_paths
        )

    def read_file(
        self,
        file_path: str,
        __user__: dict = {},
    ) -> str:
        """
        Read contents of a file.
        :param file_path: Path to the file to read
        :return: File contents as string
        """
        try:
            if not self._is_path_allowed(file_path):
                return f"Error: Access denied. Path {file_path} is not in allowed directories."
            if not os.path.exists(file_path):
                return f"Error: File {file_path} does not exist."
            file_size = os.path.getsize(file_path)
            if file_size > self.valves.max_file_size:
                return f"Error: File size ({file_size} bytes) exceeds maximum ({self.valves.max_file_size} bytes)."
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()
            return f"Successfully read {file_path}:\n\n{content}"
        except Exception as e:
            return f"Error reading file: {str(e)}"

    def write_file(
        self,
        file_path: str,
        content: str,
        mode: str = "w",
        __user__: dict = {},
    ) -> str:
        """
        Write content to a file.
        :param file_path: Path to the file to write
        :param content: Content to write to the file
        :param mode: Write mode - 'w' for overwrite, 'a' for append
        :return: Success or error message
        """
        try:
            if not self._is_path_allowed(file_path):
                return f"Error: Access denied. Path {file_path} is not in allowed directories."
            if len(content.encode("utf-8")) > self.valves.max_file_size:
                return f"Error: Content size exceeds maximum file size limit."
            os.makedirs(os.path.dirname(file_path), exist_ok=True)
            with open(file_path, mode, encoding="utf-8") as f:
                f.write(content)
            return f"Successfully wrote to {file_path} ({len(content)} characters)"
        except Exception as e:
            return f"Error writing file: {str(e)}"

    def list_directory(
        self,
        directory_path: str,
        __user__: dict = {},
    ) -> str:
        """
        List contents of a directory.
        :param directory_path: Path to the directory to list
        :return: JSON string with directory contents
        """
        try:
            if not self._is_path_allowed(directory_path):
                return f"Error: Access denied. Path {directory_path} is not in allowed directories."
            if not os.path.exists(directory_path):
                return f"Error: Directory {directory_path} does not exist."
            if not os.path.isdir(directory_path):
                return f"Error: {directory_path} is not a directory."
            items = []
            for item in os.listdir(directory_path):
                item_path = os.path.join(directory_path, item)
                stat = os.stat(item_path)
                items.append(
                    {
                        "name": item,
                        "type": "directory" if os.path.isdir(item_path) else "file",
                        "size": stat.st_size,
                        "modified": stat.st_mtime,
                    }
                )
            return json.dumps(items, indent=2)
        except Exception as e:
            return f"Error listing directory: {str(e)}"

    def delete_file(
        self,
        file_path: str,
        __user__: dict = {},
    ) -> str:
        """
        Delete a file.
        :param file_path: Path to the file to delete
        :return: Success or error message
        """
        try:
            if not self._is_path_allowed(file_path):
                return f"Error: Access denied. Path {file_path} is not in allowed directories."
            if not os.path.exists(file_path):
                return f"Error: File {file_path} does not exist."
            os.remove(file_path)
            return f"Successfully deleted {file_path}"
        except Exception as e:
            return f"Error deleting file: {str(e)}"
