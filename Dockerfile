FROM rocker/verse:4.4.2
LABEL description="Docker image for Seurat5."

# Install system dependencies
RUN apt-get update && apt-get install -y \ 
    libhdf5-dev build-essential libxml2-dev libssl-dev libv8-dev libsodium-dev \
    libglpk40 libgdal-dev libboost-dev libomp-dev libbamtools-dev libboost-iostreams-dev \
    libboost-log-dev libboost-system-dev libboost-test-dev libcurl4-openssl-dev libz-dev \
    libarmadillo-dev libgsl0-dev gsl-bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install CRAN packages
RUN R -e "install.packages(c('Seurat','hdf5r','DT','dplyr','cowplot','knitr','slingshot', \
    'msigdbr','remotes','metap','devtools','R.utils','ggalt','ggpubr','BiocManager', \
    'clustree','SoupX','gprofiler2','VAM','openxlsx','kableExtra','scSorter','plotly', \
    'RColorBrewer','SeuratObject','umap','patchwork'), repos='http://cran.rstudio.com/', dependencies=TRUE)"

# Install Bioconductor packages
RUN R -e "BiocManager::install(c('SingleR','slingshot','scRNAseq','celldex','fgsea','multtest', \
    'scuttle','BiocGenerics','DelayedArray','edgeR','dittoSeq','scDataviz','glmGamPoi', \
    'GSEABase','ComplexHeatmap','UCell','DelayedMatrixStats','limma','S4Vectors', \
    'SingleCellExperiment','SummarizedExperiment','batchelor','org.Mm.eg.db', 'org.Hs.eg.db', \
    'AnnotationHub','scater','edgeR','apeglm','DESeq2','pcaMethods','clusterProfiler','sva','scRepertoire','PCAtools'))"

# Install GitHub packages
RUN R -e "remotes::install_github(c('satijalab/seurat-wrappers', \
    'kevinblighe/EnhancedVolcano', 'cole-trapnell-lab/monocle3', \
    'hypercompetent/colorway', 'powellgenomicslab/DropletQC', \
    'samuel-marsh/scCustomize', 'chris-mcginnis-ucsf/DoubletFinder'))"

RUN R -e "BiocManager::install('TFBSTools')"
RUN R -e "remotes::install_github('satijalab/azimuth', ref = 'master')"

