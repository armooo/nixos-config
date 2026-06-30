{pkgs, ...}:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_CONTEXT_LENGTH = "128000";
    };
  };
}
