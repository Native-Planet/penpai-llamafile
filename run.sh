#!/bin/bash
FILE_PATH="./${MODEL_FILE}"
chmod +x ${FILE_PATH}
echo "Running ${MODEL_FILE}..."
/bin/sh -c ${FILE_PATH} --nobrowser --host 0.0.0.0
