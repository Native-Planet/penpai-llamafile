#!/bin/bash

verify_hash() {
    local file_path="$1"
    local expected_hash="$2"
    local file_hash

    file_hash=$(sha256sum "$file_path" | awk '{print $1}')
    if [[ "$file_hash" == "$expected_hash" ]]; then
        return 0 # Hash matches
    else
        return 1 # Hash does not match
    fi
}

model="$MODEL"

if [ -z "$model" ]; then
    echo "Supported models are mistral-7b, mixtral-8x7b, wizardoder-34b,
    wizardcoder13b, llava-1.5, tinyllama-1.1b, rocket-3b" 
    echo "No model value provided. Defaulting to mistral-7b"
    model="Mistral-7B-Instruct"
fi

case $model in
    Mistral-7B-Instruct)
        MODEL_NAME="Mistral-7B-Instruct"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/Mistral-7B-Instruct-v0.2-llamafile/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.llamafile?download=true"
        MODEL_HASH="d5a08c4b7696852158561c1b3091d555d35ef248e2e8b9ceab4c98fb99d43b4f"
        ;;
    Mixtral-8x7B-Instruct)
        MODEL_NAME="Mixtral-8x7B-Instruct"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/Mixtral-8x7B-Instruct-v0.1-llamafile/resolve/main/mixtral-8x7b-instruct-v0.1.Q5_K_M.llamafile?download=true"
        MODEL_HASH="35993b65650dba4fc56d3b1dbeaa2e834dc175635d5d2d41b11ee9d6fd9ff32b"
        ;;
    WizardCoder-Python-34B)
        MODEL_NAME="WizardCoder-Python-34B"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/WizardCoder-Python-34B-V1.0-llamafile/resolve/main/wizardcoder-python-34b-v1.0.Q5_K_M.llamafile?download=true"
        MODEL_HASH="77fd18c4925732a9d0e5116ce59492e410cd48193554c4ac34cb3ccd13da4a35"
        ;;
    WizardCoder-Python-13B)
        MODEL_NAME="WizardCoder-Python-13B"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/wizardcoder-13b-python/resolve/main/wizardcoder-python-13b.llamafile?download=true"
        MODEL_HASH="812f015f6e100d0bab2a00b22f7a21b667efa1bf8c1f9fe64b60d88288212af1"
        ;;
    LLaVA-1.5)
        MODEL_NAME="LLaVA-1.5"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/llava-v1.5-7B-GGUF/resolve/main/llava-v1.5-7b-q4.llamafile?download=true"
        MODEL_HASH="94540579a47220c37aab60ea856b7acb283f7e01599ae0535712cf48d83f05bb"
        ;;
    TinyLlama-1.1B)
         MODEL_NAME="TinyLlama-1.1B"
         MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile?download=true"
         MODEL_HASH="f669ecefad99bb1a2e36dfd48c0ff230dc28fc025998a06f34a15dde9b5c6522"
         ;;
    Rocket-3B)
         MODEL_NAME="Rocket-3B"
         MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/rocket-3B-llamafile/resolve/main/rocket-3b.Q5_K_M.llamafile?download=true"
         MODEL_HASH="4162cdf7fbf63d854218ea8a91e50962dd180ec2e392e2396563d89830f8e828"
         ;;
    *)
        echo "Invalid model value provided. Supported models are 7b, 13b, 70b, code-7b, code-13b, code-34b."
        exit 1
        ;;
esac

FILE_PATH="./${MODEL_NAME}"
if [ -f "$FILE_PATH" ]; then
    echo "Model file $MODEL_NAME exists. Verifying integrity..."
    if verify_hash "$FILE_PATH" "$MODEL_HASH"; then
        echo "File integrity verified. No download needed."
    else
        echo "File integrity failed. Downloading model..."
        wget -q -O "$FILE_PATH" "$MODEL_DOWNLOAD_URL" || { echo "Failed to download model."; exit 1; }
    fi
else
    echo "Model file $MODEL_NAME does not exist. Downloading..."
    wget -q -O "$FILE_PATH" "$MODEL_DOWNLOAD_URL" || { echo "Failed to download model."; exit 1; }
fi
echo "Running ${MODEL_NAME}..."
/bin/sh -c ./${MODEL_NAME}
