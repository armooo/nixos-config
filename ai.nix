{...}:
{
  services.ollama = {
    enable = true;
    acceleration = "vulkan";
    loadModels = [
      "gpt-oss:20b"
      "deepseek-r1:8b"
    ];
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_CONTEXT_LENGTH = "128000";
    };
  };
}
