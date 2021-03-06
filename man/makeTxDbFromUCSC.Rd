\name{makeTxDbFromUCSC}

\alias{supportedUCSCtables}
\alias{getChromInfoFromUCSC}
\alias{makeTxDbFromUCSC}

\title{
  Make a TxDb object from annotations available at the
  UCSC Genome Browser
}
\description{
  The \code{makeTxDbFromUCSC} function allows the user
  to make a \link{TxDb} object from transcript annotations
  available at the UCSC Genome Browser.
}
\usage{
supportedUCSCtables()

makeTxDbFromUCSC(
        genome="hg19",
        tablename="knownGene",
        transcript_ids=NULL,
        circ_seqs=DEFAULT_CIRC_SEQS,
        url="http://genome.ucsc.edu/cgi-bin/",
        goldenPath_url="http://hgdownload.cse.ucsc.edu/goldenPath",
        taxonomyId=NA,
        miRBaseBuild=NA)

getChromInfoFromUCSC(
        genome,
        goldenPath_url="http://hgdownload.cse.ucsc.edu/goldenPath")
}
\arguments{
  \item{genome}{genome abbreviation used by UCSC and obtained by
    \code{\link[rtracklayer]{ucscGenomes}()[ , "db"]}.
    For example: \code{"hg19"}.}
  \item{tablename}{name of the UCSC table containing the transcript
    annotations to retrieve. Use the \code{supportedUCSCtables} utility
    function to get the list of supported tables. Note that not all
    tables are available for all genomes.}
  \item{transcript_ids}{optionally, only retrieve transcript
    annotation data for the specified set of transcript ids.
    If this is used, then the meta information displayed for the
    resulting \link{TxDb} object will say 'Full dataset: no'.
    Otherwise it will say 'Full dataset: yes'.}
  \item{circ_seqs}{a character vector to list out which chromosomes
    should be marked as circular.}
  \item{url,goldenPath_url}{use to specify the location of an
    alternate UCSC Genome Browser.}
  \item{taxonomyId}{By default this value is NA and the organism
    inferred will be used to look up the correct value for this.  But
    you can use this argument to supply your own valid taxId here.}
  \item{miRBaseBuild}{specify the string for the appropriate build
    Information from mirbase.db to use for microRNAs.  This can be
    learned by calling \code{supportedMiRBaseBuildValues}.  By default,
    this value will be set to \code{NA}, which will inactivate the
    \code{microRNAs} accessor.}
}
\details{
  \code{makeTxDbFromUCSC} is a convenience function that feeds
  data from the UCSC source to the lower level \code{\link{makeTxDb}}
  function.
  See \code{?\link{makeTxDbFromBiomart}} for a similar function
  that feeds data from a BioMart database.
}

\value{
  A \link{TxDb} object for \code{makeTxDbFromUCSC}.

  A data frame with 1 row per chromosome (or scaffold) and with columns
  \code{chrom} and \code{length} for \code{getChromInfoFromUCSC}.
}

\author{
  M. Carlson and H. Pages
}

\seealso{
  \itemize{
    \item \code{\link{makeTxDbFromBiomart}}, \code{\link{makeTxDbFromGRanges}},
          and \code{\link{makeTxDbFromGFF}}, for convenient ways to make a
          \link{TxDb} object from BioMart online resources, or from a
          \link[GenomicRanges]{GRanges} object, or from a GFF or GTF file.

    \item \code{\link[rtracklayer]{ucscGenomes}} in the \pkg{rtracklayer}
          package.

    \item \code{\link{DEFAULT_CIRC_SEQS}}.

    \item The \code{\link{supportedMiRBaseBuildValues}} function for
          listing all the possible values for the \code{miRBaseBuild}
          argument.

    \item The \link{TxDb} class.

    \item \code{\link{makeTxDb}} for the low-level function used by the
          \code{makeTxDbFrom*} functions to make the \link{TxDb} object
          returned to the user.
  }
}

\examples{
## ---------------------------------------------------------------------
## A. BASIC USAGE
## ---------------------------------------------------------------------

## Use ucscGenomes() from the rtracklayer package to display the list of
## genomes available at UCSC:
library(rtracklayer)
ucscGenomes()[ , "db"]

## Display the list of tables supported by makeTxDbFromUCSC():
supportedUCSCtables()

## Retrieve a full transcript dataset for Yeast from UCSC:
txdb1 <- makeTxDbFromUCSC(genome="sacCer3", tablename="ensGene",
                          circ_seqs="chrM")
txdb1

## Retrieve an incomplete transcript dataset for Mouse from UCSC (only
## transcripts linked to Entrez Gene ID 22290):
transcript_ids <- c(
    "uc009uzf.1",
    "uc009uzg.1",
    "uc009uzh.1",
    "uc009uzi.1",
    "uc009uzj.1"
)

txdb2 <- makeTxDbFromUCSC(genome="mm10", tablename="knownGene",
                          transcript_ids=transcript_ids,
                          circ_seqs="chrM")
txdb2

## ---------------------------------------------------------------------
## B. RETRIEVING CHROMOSOME INFORMATION ONLY
## ---------------------------------------------------------------------

chrominfo <- getChromInfoFromUCSC(genome="hg38")
chrominfo
}
