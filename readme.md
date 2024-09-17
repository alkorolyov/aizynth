```shell
pip install pip-system-certs
mamba create -n aiz python=3.10 ipykernel
conda activate aiz
python -m ipykernel install --name aiz --user
python -m pip install aizynthfinder[all]
pip install --upgrade jupyter
pip install --upgrade notebook
pip install --upgrade ipywidgets

download_public_data .
```

```python
from aizynthfinder.interfaces import AiZynthApp
app = AiZynthApp("/path/to/configfile.yaml")
```