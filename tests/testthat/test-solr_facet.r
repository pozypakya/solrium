context("solr_facet")

test_that("solr_facet works", {
  skip_on_cran()
  
  conn <- solr_connect('http://api.plos.org/search')
  
  a <- solr_facet(conn, q='*:*', facet.field='journal', verbose=FALSE)
  b <- solr_facet(conn, q='*:*', facet.date='publication_date', facet.date.start='NOW/DAY-5DAYS', facet.date.end='NOW', facet.date.gap='+1DAY', verbose=FALSE)
  
  # correct dimenions
  expect_equal(length(a), 4)
  expect_equal(length(a$facet_queries), 0)
  expect_equal(NCOL(a$facet_fields$journal), 2)
  
  expect_that(length(b), equals(4))
  expect_that(length(b$facet_dates), equals(1))
  expect_that(dim(b$facet_dates$publication_date), equals(c(6,2)))

  # correct classes
  expect_is(a, "list")
  expect_is(b, "list")
  expect_is(b$facet_dates, "list")
  expect_is(b$facet_dates$publication_date, "data.frame")
})
