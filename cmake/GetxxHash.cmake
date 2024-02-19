cmake_minimum_required ( VERSION 3.17 FATAL_ERROR )

set ( XXH_REPO "https://github.com/manticoresoftware/xxHash" )
set ( XXH_REV "15ba9e4" )
set ( XXH_SRC_MD5 "fbe492d51138081e8789cd1e7e16f59b" )

set ( XXH_GITHUB "${XXH_REPO}/archive/${XXH_REV}.zip" )
set ( XXH_BUNDLE "${LIBS_BUNDLE}/xxHash-${XXH_REV}.zip" )

include ( update_bundle )

# try to find quietly (will work most time
find_package ( xxhash QUIET CONFIG )
return_if_target_found ( xxhash::xxhash "found ready (no need to build)" )

# not found. Populate and prepare sources
select_nearest_url ( XXH_PLACE xxhash ${XXH_BUNDLE} ${XXH_GITHUB} )
fetch_and_check ( xxhash ${XXH_PLACE} ${XXH_SRC_MD5} XXH_SRC )

# build external project
get_build ( XXH_BUILD xxhash )
set ( XXHASH_BUILD_XXHSUM OFF CACHE BOOL "" FORCE )
external_build ( xxhash XXH_SRC XXH_BUILD BUILD_SHARED_LIBS=0 )

# now it should find
find_package ( xxhash REQUIRED CONFIG )
return_if_target_found ( xxhash::xxhash "was built and saved" )
