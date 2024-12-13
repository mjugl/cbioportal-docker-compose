This is a workaround for cBioPortal to support passing API tokens into its data import scripts ([see relevant issue](https://github.com/cBioPortal/cbioportal-core/issues/69)).
There is a patch in the `validateData.py` script that reads an API token from the `CBP_API_TOKEN` environment variable.
If present, it will attach the token to outgoing requests.
The Dockerfile also includes code for setting up intermediate certificates which is necessary for our purposes.

Data can be imported by [modifying the example](https://docs.cbioportal.org/deployment/docker/) from the documentation like so:

```
docker compose run cbioportal -e "CBP_API_TOKEN=XXX_token_goes_here_XXX" validateData.py -u https://url.to.cbp -s study/lgg_ucsf_2014/ -v
```