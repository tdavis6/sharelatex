FROM sharelatex/sharelatex:latest
RUN apt-get update && apt install -y context libxml-libxslt-perl cpanminus && rm -rf /var/lib/apt/lists/*
RUN mtxrun --generate && mktexlsr && updmap-sys && fmtutil-sys --all
RUN cpanm install Module::Build && cpanm install PAR::Packer; rm -fr root/.cpanm; exit 0
RUN tlmgr install scheme-full
RUN cd /home && wget https://github.com/plk/biber/archive/refs/tags/v2.19.zip && unzip v2.19.zip && cd biber-2.19/ && perl ./Build.PL && ./Build installdeps && ldconfig && ./Build test && ./Build install