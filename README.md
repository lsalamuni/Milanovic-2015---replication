\documentclass[12pt]{article}

% -----------------------------------------------------
% pacotes já existentes
\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amsthm,amssymb}
\usepackage[most]{tcolorbox}
\usepackage{booktabs}   % linhas horizontais elegantes
\usepackage{tabularx}   % quebra automática de coluna
\usepackage{array}      % >{\centering\arraybackslash}
\usepackage{graphicx}
\usepackage{subcaption}
\usepackage{float}
\usepackage[margin=1in]{geometry}
\usepackage{hyperref}

% -----------------------------------------------------
% cores para o cabeçalho
\usepackage{xcolor}                     % NOVO
\definecolor{headergray}{gray}{0.55}    % ajuste o tom aqui

% -----------------------------------------------------
% ---  cabeçalho/rodapé (fancyhdr) --------------------
\usepackage{fancyhdr}

\pagestyle{fancy}
\fancyhf{}                      % limpa tudo

% --------- cabeçalho padrão (da 2ª página em diante) ----------
\lhead{\color{headergray}\parbox[b]{0.46\textwidth}{%
       Lucas Salamuni\\
       7429674}}
\rhead{\color{headergray}\parbox[b]{0.46\textwidth}{%
       R.G. Microeconomics/Summer~2025\\
       Final Project}}




\title{README: \\
``Global inequality of opportunity'' replication}
\date{}

\begin{document}

\maketitle

\section*{Introduction}

The replication consists of the following files:

\medskip

\textbf{Code files (4):}
\begin{itemize}
    \item ``1\_pure\_replication.R''
    \item ``2\_cross-continent\_analysis.R''
    \item ``3\_income\_importance\_for\_brazilian\_migration.R''
    \item ``Plots.R''
\end{itemize}

\textbf{Data files (13):}
\begin{itemize}
    \item ``final08\_1.RData''
    \item ``BRA\_expats.xlsx''
    \item ``country\_mapping.RData''
    \item ``languages.csv''
    \item ``forms.csv''
    \item ``parameters.csv''
    \item ``Brazil\_Immigration\_1884-1953.csv''
    \item ``DEMIG\_VISA\_Database\_version\_1.4.xlsx''
    \item ``IMPICDatasetV2\_1980-2018.dta''
    \item ``undesa\_pd\_2024\_ims\_stock\_by\_sex\_destination\_and\_origin.xlsx''
    \item ``Coup\_data\_2.2.0.csv''
    \item ``WYD\_reg.xlsx''
    \item ``replication\_results\_part1.RData''
\end{itemize}

All code and data files are used across four stages, which can be run separately, independently, and can be found at the following github repository: \href{https://github.com/lsalamuni/Milanovic-2015---replication/tree/main}{\textcolor{blue}{Milanovic-2015 replication}}

The original data set, as well as Stata codes, are available at \href{https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/27326}{\textcolor{blue}{dataverse.harvard.edu}}. 

\section{Pure Replication}

\subsection{Data}

The data file is called ``final08\_1.RData''. It is a R file which contains all the variables needed to run the regressions and get the results reported in the paper.

\subsubsection{Variables:}

\begin{itemize}
    \item \textbf{contcod} = country three-letter World Bank acronym.
    
    \item \textbf{group} = income percentile (running from 1=poorest percentile to 100=richest percentile). A percentile contains 1\% of a country's population.
    
    \item \textbf{maxgroup} = total number of groups for a country. All but one country have 100 groups, that is 100 percentiles.
    
    \item \textbf{inc} = real annual per capita income of a given country/percentile in the year 2008. The values are in 2005 international (ppp) dollars. Calculated from countries' household surveys conducted in the year given by the variable survey\_year. If survey year is not 2008, the values are brought into 2008 values by the use of country's Consumer Price Index.
    
    \item \textbf{survey\_year} = year in which household survey was conducted. (About 2/3 of surveys are conducted in the benchmark year 2008; almost 90\% of surveys are conducted in the window 2007-09.)
    
    \item \textbf{year} = year into which all the variables are ``benchmarked'' (2008).
    
    \item \textbf{lninc} = ln(inc).
    
    \item \textbf{gdpppp} = GDP per capita for the year 2008; expressed in 2005 international (ppp) dollars. The data are from World Bank World Development Indicators.
    
    \item \textbf{lngdppp} = ln(gdpppp).
    
    \item \textbf{pop} = population size (in million) of each country/percentile in the year 2008. The data are from World Bank World Development Indicators.
    
    \item \textbf{gini} = country's Gini coefficient.
    
    \item \textbf{ayos} = average number of years of education if age$>$15, by country; from 2012 World Bank World Development Indicators.
\end{itemize}

All the variables are original to the paper (WYD).

All the other variables used in the paper are created from these variables.


\subsection{Code}

The code used is provided in ``1\_pure\_replication.R''.

All the R packages needed to run the code are available on CRAN and should be automatically downloaded and loaded by simply running the code.

Finally, the results obtained by running the code.


\subsection{Final Note}

In order to run the replication, the user needs to have downloaded the comprehensive dataset used (Branko's WYD), available under ``Datasets/final08\_1.RData" as well as the code file, available under ``R\_scripts/1\_pure\_replication.R".

%--------------------------------------------------------------------------
\newpage
%--------------------------------------------------------------------------

\section{Cross-Continent Analysis}

\subsection{Data}

The data file is named ``final08\_1.RData''. This section contains no regressions or statistical models; its sole purpose is to analyze the data grouped by continent. 

\subsection{Code}

The code used is provided in ``2\_cross-continent\_analysis.R''.

All required R packages are available on CRAN and will be installed and loaded automatically when the code is run.

Finally, the results obtained by running the code (output files include ``WYD\_reg.xlsx'' and ``WYD\_cont.xlsx''). 

\subsubsection{Variables}

All variables are the same as those considered in Part 1.


\subsection{Final Note}

The user needs to have only two files in order to replicate all the results from this part. The data file (``Datasets/final08\_1.RData'') and the code file (``R\_scripts/2\_cross-continent\_analysis.R'')

%--------------------------------------------------------------------------
\newpage
%--------------------------------------------------------------------------

\section{Income Importance for Brazilian Migration}

\subsection{Data}

This section consists of organizing the final dataset used to feed the gravity model. Because the data were gathered from multiple sources, several files were used. The data files for this part include: 

\begin{itemize}
    \item ``BRA\_expats.xlsx'': number of Brazilian expats living in each country (\href{https://app.powerbi.com/view?r=eyJrIjoiMTE0OTcyYjctMGM1Mi00NGYyLTgyNjQtZjQ1YzAxMWVhZjRlIiwidCI6ImQxYjE1Y2I1LWY1MGEtNDk2NS1iYmI1LTc2ZGQ1ZmQxNzg5NyIsImMiOjN9}{\textcolor{blue}{Brazilian Ministry of Foreing Affairs}});
    \item ``country\_mapping.RData'': correction of country names between WYD and the remaining data sets utilized;
    \item ``languages.csv'', ``forms.csv'' \& ``parameters.csv'': ASJP is a large cross-linguistic wordlist resource. The latest release is distributed via Zenodo, and it provides downloadable wordlists suitable for distance/proximity measures (\href{https://zenodo.org/records/16736409}{\textcolor{blue}{Zenodo}});
    \item ``Brazil\_Immigration\_1884-1953.csv'': number of migrants, per nationality and year, that arrived in Brazil between 1884 and 1953 (\href{https://brasil500anos.ibge.gov.br/estatisticas-do-povoamento/imigracao-total-periodos-anuais.html}{\textcolor{blue}{Brazilian Institute of Geography and Statistics}});
    \item ``DEMIG\_VISA\_Database\_version\_1.4.xlsx'': visa and exit permit requirements of 214 countries for travellers of 237 countries over four decades (\href{https://www.migrationinstitute.org/data/demig-data/demig-visa-data}{\textcolor{blue}{International Migration Institute}});
    \item ``IMPICDatasetV2\_1980-2018.dta'': quantitative indices to measure immigration policies in most OECD countries and for the time period 1980-2018 (\href{http://www.impic-project.eu/data/}{\textcolor{blue}{Immigration Policies in Comparison}});
    \item ``undesa\_pd\_2024\_ims\_stock\_by\_sex\_destination\_and\_origin.xlsx'': estimates of the total number of international migrants by sex, as well as their places of origin and destination, for 233 countries and areas(\href{https://www.un.org/development/desa/pd/content/international-migrant-stock}{\textcolor{blue}{UN International Migrant Stock}});
    \item ``Coup\_data\_2.2.0.csv'': outcomes of coup events (i.e., realized, unrealized, or conspiracy), the type of actor(s) who initiated the coup (i.e., military, rebels, etc.), as well as the fate of the deposed leader (\href{https://databank.illinois.edu/datasets/IDB-7633503}{\textcolor{blue}{Cline Center Coup d’État Project Dataset}});
    \item ``WYD\_reg.xlsx'': original Branko's WYD data set with the addition of the variable ``reg", indicating the region/continent of each country listed;
    \item ``gravity\_df.RData'': used in the final gravity PPML model (combination of all other data sets gathered for such part).
\end{itemize}

\subsubsection{Variables:}

The final dataset used for the regression comprehends the following variables:

\begin{itemize}
    \item \textbf{contcod} = country three-letter World Bank acronym.
    
    \item \textbf{cont} = country's official name.
    
    \item \textbf{reg} = country's region/continent.
    
    \item \textbf{expats} = number of Brazilian expats legally living in the country.
    
    \item \textbf{language\_dist} = linguistic distance index from Brazilian-Portuguese (PT-BR).
    
    \item \textbf{cult\_dist} = cultural proximity index based on foreign migration waves to Brazil (between 1884 and 1953).
    
    \item \textbf{geo\_dist} = geographical-geodesic distance from Brazil (by distance to closest border/shoreline). The data are from the R package \textit{rnaturalearth}. 
    
    \item \textbf{visa} = baseline mobility friction (based on entry visa requirement).
    
    \item \textbf{mig\_policy} = general policy restrictiveness at destination/country with respect to migration.
    
    \item \textbf{ln\_diaspora} = Brazil-born stock in that country prior to 2008 (network effects $\rightarrow$ the idea is that a bigger Brazilian diaspora in a given country lowers costs such as general information, housing, job search, etc).
    
    \item \textbf{n\_coups} = number of realized and attempted coups/conspiracies in the country (proxy for political instability).
    
    \item \textbf{ln\_inc} = ln(inc).
    
    \item \textbf{gini} = country's Gini coefficient.
    
    \item \textbf{pop} = population size (in million) of each country in the year 2008.
    
    \item \textbf{ln\_dist} = ln(geo\_dist).
    
\end{itemize}

\subsection{Code}

The code used is provided in ``3\_income\_importance\_for\_brazilian\_migration.R''

All the R packages needed to run the code are available on CRAN and should be automatically downloaded and loaded by simply running the code.

Finally, the results obtained by running the code.

\subsection{Final Note}

The third part is the longest to complete, as it documents the entire data-collection process.

A more direct approach is also possible: the dataset used in the final model is available at ``Datasets/gravity\_df.RData''. Thus, loading that file together with the script at ``R\_scripts/3\_income\_importance\_for\_brazilian\_migration.RData'' is sufficient to replicate the outcomes of Part~3.

%--------------------------------------------------------------------------
\newpage
%--------------------------------------------------------------------------

\section{Plots}

\subsection{Data}

The data file is named ``replication\_results\_part1.RData''. This section contains no regressions or statistical models; its sole purpose is to replicate the plots utilized throughout the project. 

\subsection{Code}

The code used is provided in ``Plots.R''

All the R packages needed to run the code are available on CRAN and should be automatically downloaded and loaded by simply running the code.

Finally, the results obtained by running the code are presented. All plots are automatically saved using the \textit{ggsave} function after each chunk is executed.

\subsection{Final Note}

The user needs to have only two files in order to replicate all the results from this part. The data file (``Datasets/replication\_results\_part1.RData'') and the code file (``R\_scripts/Plots.R'').

\end{document}
