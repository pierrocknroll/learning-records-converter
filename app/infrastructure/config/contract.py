from abc import ABC, abstractmethod
from os import PathLike

from app.infrastructure.logging.types import LogLevel

from .types import Environment


class ConfigContract(ABC):
    """Abstract base class defining the contract for configuration management."""

    @abstractmethod
    def get_log_level(self) -> LogLevel:
        """Get the log level.

        :return: The log level as a string (LogLevel type).
        """
        raise NotImplementedError

    @abstractmethod
    def get_environment(self) -> Environment:
        """Get the current environment.

        :return: The current environment as a string (Environment type).
        """
        raise NotImplementedError

    def is_env_production(self) -> bool:
        """Check if the current environment is production.

        :return: True if the environment is production, False otherwise.
        """
        return self.get_environment() == Environment.PRODUCTION

    @abstractmethod
    def get_download_timeout(self) -> int:
        """Get the timeout for downloads in seconds.

        :return: The download timeout in seconds.
        """
        raise NotImplementedError

    def get_cors_allowed_origins(self) -> set[str]:
        """Get the allowed origins for CORS.

        :return: A list of allowed origins URLs.
        """
        raise NotImplementedError

    @abstractmethod
    def get_profiles_base_path(self) -> str | PathLike[str]:
        """Get the base path for profile files.

        :return: The base path as a string.
        """
        raise NotImplementedError

    @abstractmethod
    def get_and_create_profiles_base_path(self) -> str | PathLike[str]:
        """Get the base path for profile files and create the directory if it doesn't exist.

        :return: The base path as a string.
        """
        raise NotImplementedError

    @abstractmethod
    def get_profile_url(self, profile_name: str) -> str:
        """Get the URL for a specific profile.

        :param profile_name: The name of the profile.
        :return: The URL of the profile as a string.
        """
        raise NotImplementedError

    @abstractmethod
    def get_profiles_names(self) -> set[str]:
        """Get the names of all profiles.

        :return: A list of profile names.
        """
        raise NotImplementedError
