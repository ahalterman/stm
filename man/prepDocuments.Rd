\name{prepDocuments}
\alias{prepDocuments}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Prepare documents for analysis with \code{stm}
}
\description{
Performs several corpus manipulations including removing words and renumbering word indices (to correct for zero-indexing and/or unusued words in the vocab vector).
}
\usage{
prepDocuments(documents, vocab, meta, 
              lower.thresh = 1, upper.thresh = Inf, 
              subsample=NULL, verbose = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{documents}{
  List of documents. For more on the format see \code{\link{stm}}.
}
  \item{vocab}{
Character vector of words in the vocabulary.
}
  \item{meta}{
Document metadata.
}
  \item{lower.thresh}{
Words which do not appear in a number of documents greater than lower.thresh will be dropped and both the documents and vocab files will be renumbered accordingly.  If this causes all words within a document to be dropped, a message will print to the screen at it will also return vector of the documents removed so you can update your meta data as well. See details below.
}
  \item{upper.thresh}{
  As with lower.thresh but this provides an upper bound.  Words which appear in at least this number of documents will be dropped.  Defaults to \code{Inf} which does no filtering. 
  }
  \item{subsample}{
  If an integer will randomly subsample (without replacement) the given number of documents from the total corpus before any processing.  Defaults to \code{NULL} which provides no subsampling.  Note that the output may have fewer than the number of requested documents if additional processing causes some of those documents to be dropped.
}
  \item{verbose}{
A logical indicating whether or not ot print details to the screen.}
}
\details{
The default setting \code{dropthresh=1} means that words which appear in only one document will be dropped.  This is often advantageous as there is little information about these words but the added cost of including them in the model can be quite large.  In many cases it will be helpful to set this threshold considerably higher.  If the vocabulary is in excess of 5000 entries inference can slow quite a bit.

If words are removed, the function returns a vector of the original indices for the dropped items.  If it removed documents it returns a vector of doc indices removed. Users with accompanying metadata or texts may want to drop those rows from the corresponding objects.

If you have any documents which are of length 0 in your original object the function will throw an error. These should be removed before running the function although please be sure to remove the corresponding rows in the meta data file if you have one.  You can quickly identify the documents using the code: \code{which(unlist(lapply(documents, length))==0)}.
}
\value{
A list containing a new documents and vocab object.
\item{documents}{The new documents object for use with \code{stm}}
\item{vocab}{The new vocab object for use with \code{stm}}
\item{meta}{The new meta data object for use with \code{stm}. Will be the same if no documents are removed.}
\item{words.removed}{A set of indices corresponding to the positions in the original vocab object of words which have been removed.}
\item{docs.removed}{A set of indices corresponding to the positions in the original documents object of documents which no longer contained any words after dropping terms from the vocab.}
\item{wordcounts}{A table giving the the number of documents that each word is found in of the original document set, prior to any removal. This can be passed through a histogram for visual inspection.}
}

\examples{
head(gadarian)
#Process the data for analysis.
temp<-textProcessor(documents=gadarian$open.ended.response,metadata=gadarian)
meta<-temp$meta
vocab<-temp$vocab
docs<-temp$documents
out <- prepDocuments(docs, vocab, meta)
docs<-out$documents
vocab<-out$vocab
meta <-out$meta
}

