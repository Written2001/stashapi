findSavedFilter <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findSavedFilter', '
  query findSavedFilter($id: ID!) { findSavedFilter(id: $id) { ...SavedFilter } }
fragment SavedFindFilterType on SavedFindFilterType { q page per_page sort direction }
fragment SavedFilter on SavedFilter { id mode name find_filter { ...SavedFindFilterType } object_filter ui_options }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findSavedFilter,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findSavedFilters <- function(mode = NA, ...) {

  query <- ghql::Query$new()
  query$query('findSavedFilters', '
  query findSavedFilters($mode: FilterMode) { findSavedFilters(mode: $mode) { ...SavedFilter } }
fragment SavedFindFilterType on SavedFindFilterType { q page per_page sort direction }
fragment SavedFilter on SavedFilter { id mode name find_filter { ...SavedFindFilterType } object_filter ui_options }
  ')

  variables <- list()
  variables[['mode']] <- mode

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findSavedFilters,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findFile <- function(id = NA, path = NA, ...) {

  query <- ghql::Query$new()
  query$query('findFile', '
  query findFile($id: ID $path: String) { findFile(id: $id path: $path) { ...BaseFile } }
fragment Fingerprint on Fingerprint { type value }
fragment BasicFile on BasicFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment BaseFile on BaseFile { ...BasicFile ...VideoFile ...ImageFile ...GalleryFile }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['path']] <- path

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findFile,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findFiles <- function(filefilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findFiles', '
  query findFiles($filefilter: FileFilterType $filter: FindFilterType $ids: [ID!]) { findFiles(file_filter: $filefilter filter: $filter ids: $ids) { ...FindFilesResultType } }
fragment Fingerprint on Fingerprint { type value }
fragment BasicFile on BasicFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment BaseFile on BaseFile { ...BasicFile ...VideoFile ...ImageFile ...GalleryFile }
fragment FindFilesResultType on FindFilesResultType { count megapixels duration size files { ...BaseFile } }
  ')

  variables <- list()
  variables[['filefilter']] <- filefilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "files"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findFiles,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findFolder <- function(id = NA, path = NA, ...) {

  query <- ghql::Query$new()
  query$query('findFolder', '
  query findFolder($id: ID $path: String) { findFolder(id: $id path: $path) { ...Folder } }
fragment Folder on Folder { id path basename parent_folder { id path basename } parent_folders { id path basename } zip_file { id path basename } sub_folders { id path basename } mod_time created_at updated_at }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['path']] <- path

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findFolder,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findFolders <- function(folderfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findFolders', '
  query findFolders($folderfilter: FolderFilterType $filter: FindFilterType $ids: [ID!]) { findFolders(folder_filter: $folderfilter filter: $filter ids: $ids) { ...FindFoldersResultType } }
fragment Folder on Folder { id path basename parent_folder { id path basename } parent_folders { id path basename } zip_file { id path basename } sub_folders { id path basename } mod_time created_at updated_at }
fragment FindFoldersResultType on FindFoldersResultType { count folders { ...Folder } }
  ')

  variables <- list()
  variables[['folderfilter']] <- folderfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "folders"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findFolders,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findScene <- function(id = NA, checksum = NA, ...) {

  query <- ghql::Query$new()
  query$query('findScene', '
  query findScene($id: ID $checksum: String) { findScene(id: $id checksum: $checksum) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['checksum']] <- checksum

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findScene,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findSceneByHash <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('findSceneByHash', '
  query findSceneByHash($input: SceneHashInput!) { findSceneByHash(input: $input) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneHashInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findSceneByHash,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findScenes <- function(scenefilter = NA, sceneids = list(), ids = list(), filter = NA, ...) {

  query <- ghql::Query$new()
  query$query('findScenes', '
  query findScenes($scenefilter: SceneFilterType $sceneids: [Int!] $ids: [ID!] $filter: FindFilterType) { findScenes(scene_filter: $scenefilter scene_ids: $sceneids ids: $ids filter: $filter) { ...FindScenesResultType } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
fragment FindScenesResultType on FindScenesResultType { count duration filesize scenes { ...Scene } }
  ')

  variables <- list()
  variables[['scenefilter']] <- scenefilter
  variables[['sceneids']] <- sceneids
  variables[['ids']] <- ids
  variables[['filter']] <- filter

  return_default <- "scenes"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findScenes,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findScenesByPathRegex <- function(filter = NA, ...) {

  query <- ghql::Query$new()
  query$query('findScenesByPathRegex', '
  query findScenesByPathRegex($filter: FindFilterType) { findScenesByPathRegex(filter: $filter) { ...FindScenesResultType } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
fragment FindScenesResultType on FindScenesResultType { count duration filesize scenes { ...Scene } }
  ')

  variables <- list()
  variables[['filter']] <- filter

  return_default <- "scenes"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findScenesByPathRegex,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findDuplicateScenes <- function(distance = NA, durationdiff = NA, ...) {

  query <- ghql::Query$new()
  query$query('findDuplicateScenes', '
  query findDuplicateScenes($distance: Int $durationdiff: Float) { findDuplicateScenes(distance: $distance duration_diff: $durationdiff) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['distance']] <- distance
  variables[['durationdiff']] <- durationdiff

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findDuplicateScenes,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneStreams <- function(id = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneStreams', '
  query sceneStreams($id: ID) { sceneStreams(id: $id) { ...SceneStreamEndpoint } }
fragment SceneStreamEndpoint on SceneStreamEndpoint { url mime_type label }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneStreams,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

parseSceneFilenames <- function(filter = NA, config = NA, ...) {

  query <- ghql::Query$new()
  query$query('parseSceneFilenames', '
  query parseSceneFilenames($filter: FindFilterType $config: SceneParserInput!) { parseSceneFilenames(filter: $filter config: $config) { ...SceneParserResultType } }
fragment SceneMovieID on SceneMovieID { movie_id scene_index }
fragment SceneParserResult on SceneParserResult { scene { id title } title code details director url date rating100 studio_id gallery_ids performer_ids movies { ...SceneMovieID } tag_ids }
fragment SceneParserResultType on SceneParserResultType { count results { ...SceneParserResult } }
  ')

  variables <- list()
  variables[['filter']] <- filter
  variables[['config']] <- config

  if (is.null(config) || (length(config) == 1L && is.atomic(config) && is.na(config))) {
  stop("`config` is required by GraphQL type `SceneParserInput!`.", call. = FALSE)
}

  return_default <- "results"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$parseSceneFilenames,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findSceneMarkers <- function(scenemarkerfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findSceneMarkers', '
  query findSceneMarkers($scenemarkerfilter: SceneMarkerFilterType $filter: FindFilterType $ids: [ID!]) { findSceneMarkers(scene_marker_filter: $scenemarkerfilter filter: $filter ids: $ids) { ...FindSceneMarkersResultType } }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment FindSceneMarkersResultType on FindSceneMarkersResultType { count scene_markers { ...SceneMarker } }
  ')

  variables <- list()
  variables[['scenemarkerfilter']] <- scenemarkerfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "scene_markers"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findSceneMarkers,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findImage <- function(id = NA, checksum = NA, ...) {

  query <- ghql::Query$new()
  query$query('findImage', '
  query findImage($id: ID $checksum: String) { findImage(id: $id checksum: $checksum) { ...Image } }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
fragment ImagePathsType on ImagePathsType { thumbnail preview }
fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['checksum']] <- checksum

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findImage,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findImages <- function(imagefilter = NA, imageids = list(), ids = list(), filter = NA, ...) {

  query <- ghql::Query$new()
  query$query('findImages', '
  query findImages($imagefilter: ImageFilterType $imageids: [Int!] $ids: [ID!] $filter: FindFilterType) { findImages(image_filter: $imagefilter image_ids: $imageids ids: $ids filter: $filter) { ...FindImagesResultType } }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
fragment ImagePathsType on ImagePathsType { thumbnail preview }
fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
fragment FindImagesResultType on FindImagesResultType { count megapixels filesize images { ...Image } }
  ')

  variables <- list()
  variables[['imagefilter']] <- imagefilter
  variables[['imageids']] <- imageids
  variables[['ids']] <- ids
  variables[['filter']] <- filter

  return_default <- "images"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findImages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findPerformer <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findPerformer', '
  query findPerformer($id: ID!) { findPerformer(id: $id) { ...Performer } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findPerformer,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findPerformers <- function(performerfilter = NA, filter = NA, performerids = list(), ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findPerformers', '
  query findPerformers($performerfilter: PerformerFilterType $filter: FindFilterType $performerids: [Int!] $ids: [ID!]) { findPerformers(performer_filter: $performerfilter filter: $filter performer_ids: $performerids ids: $ids) { ...FindPerformersResultType } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
fragment FindPerformersResultType on FindPerformersResultType { count performers { ...Performer } }
  ')

  variables <- list()
  variables[['performerfilter']] <- performerfilter
  variables[['filter']] <- filter
  variables[['performerids']] <- performerids
  variables[['ids']] <- ids

  return_default <- "performers"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findPerformers,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findStudio <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findStudio', '
  query findStudio($id: ID!) { findStudio(id: $id) { ...Studio } }
fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findStudio,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findStudios <- function(studiofilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findStudios', '
  query findStudios($studiofilter: StudioFilterType $filter: FindFilterType $ids: [ID!]) { findStudios(studio_filter: $studiofilter filter: $filter ids: $ids) { ...FindStudiosResultType } }
fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
fragment FindStudiosResultType on FindStudiosResultType { count studios { ...Studio } }
  ')

  variables <- list()
  variables[['studiofilter']] <- studiofilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "studios"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findStudios,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findGroup <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGroup', '
  query findGroup($id: ID!) { findGroup(id: $id) { ...Group } }
fragment GroupDescription on GroupDescription { group { id name } description }
fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findGroup,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findGroups <- function(groupfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGroups', '
  query findGroups($groupfilter: GroupFilterType $filter: FindFilterType $ids: [ID!]) { findGroups(group_filter: $groupfilter filter: $filter ids: $ids) { ...FindGroupsResultType } }
fragment GroupDescription on GroupDescription { group { id name } description }
fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
fragment FindGroupsResultType on FindGroupsResultType { count groups { ...Group } }
  ')

  variables <- list()
  variables[['groupfilter']] <- groupfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "groups"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findGroups,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findGallery <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGallery', '
  query findGallery($id: ID!) { findGallery(id: $id) { ...Gallery } }
fragment Fingerprint on Fingerprint { type value }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
fragment GalleryPathsType on GalleryPathsType { cover preview }
fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findGallery,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findGalleries <- function(galleryfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGalleries', '
  query findGalleries($galleryfilter: GalleryFilterType $filter: FindFilterType $ids: [ID!]) { findGalleries(gallery_filter: $galleryfilter filter: $filter ids: $ids) { ...FindGalleriesResultType } }
fragment Fingerprint on Fingerprint { type value }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
fragment GalleryPathsType on GalleryPathsType { cover preview }
fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
fragment FindGalleriesResultType on FindGalleriesResultType { count galleries { ...Gallery } }
  ')

  variables <- list()
  variables[['galleryfilter']] <- galleryfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "galleries"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findGalleries,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findTag <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findTag', '
  query findTag($id: ID!) { findTag(id: $id) { ...Tag } }
fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findTag,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findTags <- function(tagfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findTags', '
  query findTags($tagfilter: TagFilterType $filter: FindFilterType $ids: [ID!]) { findTags(tag_filter: $tagfilter filter: $filter ids: $ids) { ...FindTagsResultType } }
fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
fragment FindTagsResultType on FindTagsResultType { count tags { ...Tag } }
  ')

  variables <- list()
  variables[['tagfilter']] <- tagfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "tags"
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findTags,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

markerWall <- function(q = NA, ...) {

  query <- ghql::Query$new()
  query$query('markerWall', '
  query markerWall($q: String) { markerWall(q: $q) { ...SceneMarker } }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['q']] <- q

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$markerWall,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneWall <- function(q = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneWall', '
  query sceneWall($q: String) { sceneWall(q: $q) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['q']] <- q

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneWall,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

markerStrings <- function(q = NA, sort = NA, ...) {

  query <- ghql::Query$new()
  query$query('markerStrings', '
  query markerStrings($q: String $sort: String) { markerStrings(q: $q sort: $sort) { ...MarkerStringsResultType } }
fragment MarkerStringsResultType on MarkerStringsResultType { count id title }
  ')

  variables <- list()
  variables[['q']] <- q
  variables[['sort']] <- sort

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$markerStrings,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

stats <- function(...) {

  query <- ghql::Query$new()
  query$query('stats', '
  query stats { stats { ...StatsResultType } }
fragment StatsResultType on StatsResultType { scene_count scenes_size scenes_duration image_count images_size gallery_count performer_count studio_count group_count tag_count total_o_count total_play_duration total_play_count scenes_played }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$stats,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneMarkerTags <- function(sceneid = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerTags', '
  query sceneMarkerTags($sceneid: ID!) { sceneMarkerTags(scene_id: $sceneid) { ...SceneMarkerTag } }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneMarkerTag on SceneMarkerTag { tag { id name } scene_markers { ...SceneMarker } }
  ')

  variables <- list()
  variables[['sceneid']] <- sceneid

  if (is.null(sceneid) || (length(sceneid) == 1L && is.atomic(sceneid) && is.na(sceneid)) || (is.list(sceneid) && length(sceneid) == 0L)) {
  stop("`sceneid` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneMarkerTags,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

logs <- function(...) {

  query <- ghql::Query$new()
  query$query('logs', '
  query logs { logs { ...LogEntry } }
fragment LogEntry on LogEntry { time level message }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$logs,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

listScrapers <- function(types = NA, ...) {

  query <- ghql::Query$new()
  query$query('listScrapers', '
  query listScrapers($types: [ScrapeContentType!]!) { listScrapers(types: $types) { ...Scraper } }
fragment ScraperSpec on ScraperSpec { urls supported_scrapes }
fragment Scraper on Scraper { id name performer { ...ScraperSpec } scene { ...ScraperSpec } gallery { ...ScraperSpec } group { ...ScraperSpec } }
  ')

  variables <- list()
  variables[['types']] <- types

  if (is.null(types) || (length(types) == 1L && is.atomic(types) && is.na(types))) {
  stop("`types` is required by GraphQL type `[ScrapeContentType!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$listScrapers,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSingleScene <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleScene', '
  query scrapeSingleScene($source: ScraperSourceInput! $input: ScrapeSingleSceneInput!) { scrapeSingleScene(source: $source input: $input) { ...ScrapedScene } }
fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedGroup on ScrapedGroup { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
fragment ScrapedScene on ScrapedScene { title code details director urls date file { ...SceneFileType } studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } remote_site_id duration fingerprints { ...StashBoxFingerprint } }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSingleSceneInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSingleScene,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeMultiScenes <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeMultiScenes', '
  query scrapeMultiScenes($source: ScraperSourceInput! $input: ScrapeMultiScenesInput!) { scrapeMultiScenes(source: $source input: $input) { ...ScrapedScene } }
fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedGroup on ScrapedGroup { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
fragment ScrapedScene on ScrapedScene { title code details director urls date file { ...SceneFileType } studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } remote_site_id duration fingerprints { ...StashBoxFingerprint } }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeMultiScenesInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeMultiScenes,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSingleStudio <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleStudio', '
  query scrapeSingleStudio($source: ScraperSourceInput! $input: ScrapeSingleStudioInput!) { scrapeSingleStudio(source: $source input: $input) { ...ScrapedStudio } }
fragment ScrapedStudio on ScrapedStudio { stored_id name urls parent { stored_id name } details aliases tags { stored_id name description alias_list remote_site_id } remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSingleStudioInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSingleStudio,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSingleTag <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleTag', '
  query scrapeSingleTag($source: ScraperSourceInput! $input: ScrapeSingleTagInput!) { scrapeSingleTag(source: $source input: $input) { ...ScrapedTag } }
fragment ScrapedTag on ScrapedTag { stored_id name description alias_list parent { stored_id name description alias_list remote_site_id } remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSingleTagInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSingleTag,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSinglePerformer <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSinglePerformer', '
  query scrapeSinglePerformer($source: ScraperSourceInput! $input: ScrapeSinglePerformerInput!) { scrapeSinglePerformer(source: $source input: $input) { ...ScrapedPerformer } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSinglePerformerInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSinglePerformer,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeMultiPerformers <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeMultiPerformers', '
  query scrapeMultiPerformers($source: ScraperSourceInput! $input: ScrapeMultiPerformersInput!) { scrapeMultiPerformers(source: $source input: $input) { ...ScrapedPerformer } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeMultiPerformersInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeMultiPerformers,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSingleGallery <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleGallery', '
  query scrapeSingleGallery($source: ScraperSourceInput! $input: ScrapeSingleGalleryInput!) { scrapeSingleGallery(source: $source input: $input) { ...ScrapedGallery } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedGallery on ScrapedGallery { title code details photographer urls date studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSingleGalleryInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSingleGallery,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSingleGroup <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleGroup', '
  query scrapeSingleGroup($source: ScraperSourceInput! $input: ScrapeSingleGroupInput!) { scrapeSingleGroup(source: $source input: $input) { ...ScrapedGroup } }
fragment ScrapedGroup on ScrapedGroup { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSingleGroupInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSingleGroup,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSingleImage <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleImage', '
  query scrapeSingleImage($source: ScraperSourceInput! $input: ScrapeSingleImageInput!) { scrapeSingleImage(source: $source input: $input) { ...ScrapedImage } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedImage on ScrapedImage { title code details photographer urls date studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source))) {
  stop("`source` is required by GraphQL type `ScraperSourceInput!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScrapeSingleImageInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSingleImage,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeURL <- function(url = list(), ty = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeURL', '
  query scrapeURL($url: String! $ty: ScrapeContentType!) { scrapeURL(url: $url ty: $ty) { ...ScrapedContent } }
fragment ScrapedStudio on ScrapedStudio { stored_id name urls parent { stored_id name } details aliases tags { stored_id name description alias_list remote_site_id } remote_site_id }
fragment ScrapedTag on ScrapedTag { stored_id name description alias_list parent { stored_id name description alias_list remote_site_id } remote_site_id }
fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedGroup on ScrapedGroup { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
fragment ScrapedScene on ScrapedScene { title code details director urls date file { ...SceneFileType } studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } remote_site_id duration fingerprints { ...StashBoxFingerprint } }
fragment ScrapedGallery on ScrapedGallery { title code details photographer urls date studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } }
fragment ScrapedImage on ScrapedImage { title code details photographer urls date studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } }
fragment ScrapedMovie on ScrapedMovie { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
fragment ScrapedContent on ScrapedContent { ...ScrapedStudio ...ScrapedTag ...ScrapedScene ...ScrapedGallery ...ScrapedImage ...ScrapedMovie ...ScrapedGroup ...ScrapedPerformer }
  ')

  variables <- list()
  variables[['url']] <- url
  variables[['ty']] <- ty

  if (is.null(url) || (length(url) == 1L && is.atomic(url) && is.na(url)) || (is.list(url) && length(url) == 0L)) {
  stop("`url` is required by GraphQL type `String!`.", call. = FALSE)
}
  if (is.null(ty) || (length(ty) == 1L && is.atomic(ty) && is.na(ty))) {
  stop("`ty` is required by GraphQL type `ScrapeContentType!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeURL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapePerformerURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapePerformerURL', '
  query scrapePerformerURL($url: String!) { scrapePerformerURL(url: $url) { ...ScrapedPerformer } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
  ')

  variables <- list()
  variables[['url']] <- url

  if (is.null(url) || (length(url) == 1L && is.atomic(url) && is.na(url)) || (is.list(url) && length(url) == 0L)) {
  stop("`url` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapePerformerURL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeSceneURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeSceneURL', '
  query scrapeSceneURL($url: String!) { scrapeSceneURL(url: $url) { ...ScrapedScene } }
fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedGroup on ScrapedGroup { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
fragment ScrapedScene on ScrapedScene { title code details director urls date file { ...SceneFileType } studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } remote_site_id duration fingerprints { ...StashBoxFingerprint } }
  ')

  variables <- list()
  variables[['url']] <- url

  if (is.null(url) || (length(url) == 1L && is.atomic(url) && is.na(url)) || (is.list(url) && length(url) == 0L)) {
  stop("`url` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeSceneURL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeGalleryURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeGalleryURL', '
  query scrapeGalleryURL($url: String!) { scrapeGalleryURL(url: $url) { ...ScrapedGallery } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedGallery on ScrapedGallery { title code details photographer urls date studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } }
  ')

  variables <- list()
  variables[['url']] <- url

  if (is.null(url) || (length(url) == 1L && is.atomic(url) && is.na(url)) || (is.list(url) && length(url) == 0L)) {
  stop("`url` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeGalleryURL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeImageURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeImageURL', '
  query scrapeImageURL($url: String!) { scrapeImageURL(url: $url) { ...ScrapedImage } }
fragment ScrapedPerformer on ScrapedPerformer { stored_id name disambiguation gender urls birthdate ethnicity country eye_color height measurements fake_tits penis_length circumcised career_start career_end tattoos piercings aliases tags { stored_id name description alias_list remote_site_id } images details death_date hair_color weight remote_site_id }
fragment ScrapedImage on ScrapedImage { title code details photographer urls date studio { stored_id name } tags { stored_id name description alias_list remote_site_id } performers { ...ScrapedPerformer } }
  ')

  variables <- list()
  variables[['url']] <- url

  if (is.null(url) || (length(url) == 1L && is.atomic(url) && is.na(url)) || (is.list(url) && length(url) == 0L)) {
  stop("`url` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeImageURL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scrapeGroupURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeGroupURL', '
  query scrapeGroupURL($url: String!) { scrapeGroupURL(url: $url) { ...ScrapedGroup } }
fragment ScrapedGroup on ScrapedGroup { stored_id name aliases duration date rating director urls synopsis studio { stored_id name } tags { stored_id name description alias_list remote_site_id } front_image back_image }
  ')

  variables <- list()
  variables[['url']] <- url

  if (is.null(url) || (length(url) == 1L && is.atomic(url) && is.na(url)) || (is.list(url) && length(url) == 0L)) {
  stop("`url` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scrapeGroupURL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

plugins <- function(...) {

  query <- ghql::Query$new()
  query$query('plugins', '
  query plugins { plugins { ...Plugin } }
fragment PluginTask on PluginTask { name description plugin { ...Plugin } }
fragment PluginHook on PluginHook { name description hooks plugin { ...Plugin } }
fragment PluginSetting on PluginSetting { name display_name description type }
fragment PluginPaths on PluginPaths { javascript css }
fragment Plugin on Plugin { id name description url version enabled settings { ...PluginSetting } requires paths { ...PluginPaths } }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$plugins,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

pluginTasks <- function(...) {

  query <- ghql::Query$new()
  query$query('pluginTasks', '
  query pluginTasks { pluginTasks { ...PluginTask } }
fragment PluginHook on PluginHook { name description hooks plugin { ...Plugin } }
fragment PluginSetting on PluginSetting { name display_name description type }
fragment PluginPaths on PluginPaths { javascript css }
fragment Plugin on Plugin { id name description url version enabled tasks { ...PluginTask } settings { ...PluginSetting } requires paths { ...PluginPaths } }
fragment PluginTask on PluginTask { name description }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$pluginTasks,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

installedPackages <- function(type = NA, ...) {

  query <- ghql::Query$new()
  query$query('installedPackages', '
  query installedPackages($type: PackageType!) { installedPackages(type: $type) { ...Package } }
fragment Package on Package { package_id name version date sourceURL metadata }
  ')

  variables <- list()
  variables[['type']] <- type

  if (is.null(type) || (length(type) == 1L && is.atomic(type) && is.na(type))) {
  stop("`type` is required by GraphQL type `PackageType!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$installedPackages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

availablePackages <- function(type = NA, source = list(), ...) {

  query <- ghql::Query$new()
  query$query('availablePackages', '
  query availablePackages($type: PackageType! $source: String!) { availablePackages(type: $type source: $source) { ...Package } }
fragment Package on Package { package_id name version date sourceURL metadata }
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['source']] <- source

  if (is.null(type) || (length(type) == 1L && is.atomic(type) && is.na(type))) {
  stop("`type` is required by GraphQL type `PackageType!`.", call. = FALSE)
}
  if (is.null(source) || (length(source) == 1L && is.atomic(source) && is.na(source)) || (is.list(source) && length(source) == 0L)) {
  stop("`source` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$availablePackages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configuration <- function(...) {

  query <- ghql::Query$new()
  query$query('configuration', '
  query configuration { configuration { ...ConfigResult } }
fragment StashConfig on StashConfig { path excludeVideo excludeImage }
fragment StashBox on StashBox { endpoint api_key name max_requests_per_minute }
fragment PackageSource on PackageSource { name url local_path }
fragment ConfigGeneralResult on ConfigGeneralResult { stashes { ...StashConfig } databasePath backupDirectoryPath deleteTrashPath generatedPath metadataPath configFilePath scrapersPath pluginsPath cachePath blobsPath blobsStorage ffmpegPath ffprobePath calculateMD5 videoFileNamingAlgorithm parallelTasks previewAudio previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset transcodeHardwareAcceleration maxTranscodeSize maxStreamingTranscodeSize transcodeInputArgs transcodeOutputArgs liveTranscodeInputArgs liveTranscodeOutputArgs drawFunscriptHeatmapRange writeImageThumbnails createImageClipsFromVideos apiKey username password maxSessionAge logFile logOut logLevel logAccess logFileMaxSize useCustomSpriteInterval spriteInterval minimumSprites maximumSprites spriteScreenshotSize videoExtensions imageExtensions galleryExtensions createGalleriesFromFolders galleryCoverRegex excludes imageExcludes customPerformerImageLocation stashBoxes { ...StashBox } pythonPath scraperPackageSources { ...PackageSource } pluginPackageSources { ...PackageSource } }
fragment ConfigImageLightboxResult on ConfigImageLightboxResult { slideshowDelay displayMode scaleUp resetZoomOnNav scrollMode scrollAttemptsBeforeChange disableAnimation }
fragment ConfigDisableDropdownCreate on ConfigDisableDropdownCreate { performer tag studio movie gallery }
fragment ConfigInterfaceResult on ConfigInterfaceResult { sfwContentMode menuItems soundOnPreview wallShowTitle wallPlayback showScrubber maximumLoopDuration noBrowser notificationsEnabled autostartVideo autostartVideoOnPlaySelected continuePlaylistDefault showStudioAsText css cssEnabled javascript javascriptEnabled customLocales customLocalesEnabled disableCustomizations language imageLightbox { ...ConfigImageLightboxResult } disableDropdownCreate { ...ConfigDisableDropdownCreate } handyKey funscriptOffset useStashHostedFunscript }
fragment ConfigDLNAResult on ConfigDLNAResult { serverName enabled port whitelistedIPs interfaces videoSortOrder }
fragment ConfigScrapingResult on ConfigScrapingResult { scraperUserAgent scraperCDPPath scraperCertCheck excludeTagPatterns }
fragment ScanMetadataOptions on ScanMetadataOptions { rescan scanGenerateCovers scanGeneratePreviews scanGenerateImagePreviews scanGenerateSprites scanGeneratePhashes scanGenerateImagePhashes scanGenerateThumbnails scanGenerateClipPreviews }
fragment ScraperSource on ScraperSource { stash_box_endpoint scraper_id }
fragment IdentifyFieldOptions on IdentifyFieldOptions { field strategy createMissing }
fragment IdentifyMetadataOptions on IdentifyMetadataOptions { fieldOptions { ...IdentifyFieldOptions } setCoverImage setOrganized performerGenders skipMultipleMatches skipMultipleMatchTag skipSingleNamePerformers skipSingleNamePerformerTag }
fragment IdentifySource on IdentifySource { source { ...ScraperSource } options { ...IdentifyMetadataOptions } }
fragment IdentifyMetadataTaskOptions on IdentifyMetadataTaskOptions { sources { ...IdentifySource } options { ...IdentifyMetadataOptions } }
fragment AutoTagMetadataOptions on AutoTagMetadataOptions { performers studios tags }
fragment GeneratePreviewOptions on GeneratePreviewOptions { previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset }
fragment GenerateMetadataOptions on GenerateMetadataOptions { covers sprites previews imagePreviews previewOptions { ...GeneratePreviewOptions } markers markerImagePreviews markerScreenshots transcodes phashes interactiveHeatmapsSpeeds imageThumbnails clipPreviews }
fragment ConfigDefaultSettingsResult on ConfigDefaultSettingsResult { scan { ...ScanMetadataOptions } identify { ...IdentifyMetadataTaskOptions } autoTag { ...AutoTagMetadataOptions } generate { ...GenerateMetadataOptions } deleteFile deleteGenerated }
fragment ConfigResult on ConfigResult { general { ...ConfigGeneralResult } interface { ...ConfigInterfaceResult } dlna { ...ConfigDLNAResult } scraping { ...ConfigScrapingResult } defaults { ...ConfigDefaultSettingsResult } ui plugins }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configuration,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

directory <- function(path = NA, locale = NA, ...) {

  query <- ghql::Query$new()
  query$query('directory', '
  query directory($path: String $locale: String) { directory(path: $path locale: $locale) { ...Directory } }
fragment Directory on Directory { path parent directories }
  ')

  variables <- list()
  variables[['path']] <- path
  variables[['locale']] <- locale

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$directory,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

validateStashBoxCredentials <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('validateStashBoxCredentials', '
  query validateStashBoxCredentials($input: StashBoxInput!) { validateStashBoxCredentials(input: $input) { ...StashBoxValidationResult } }
fragment StashBoxValidationResult on StashBoxValidationResult { valid status }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$validateStashBoxCredentials,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

systemStatus <- function(...) {

  query <- ghql::Query$new()
  query$query('systemStatus', '
  query systemStatus { systemStatus { ...SystemStatus } }
fragment SystemStatus on SystemStatus { databaseSchema databasePath configPath appSchema status os workingDir homeDir ffmpegPath ffprobePath }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$systemStatus,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

jobQueue <- function(...) {

  query <- ghql::Query$new()
  query$query('jobQueue', '
  query jobQueue { jobQueue { ...Job } }
fragment Job on Job { id status subTasks description progress startTime endTime addTime error }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$jobQueue,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

findJob <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('findJob', '
  query findJob($input: FindJobInput!) { findJob(input: $input) { ...Job } }
fragment Job on Job { id status subTasks description progress startTime endTime addTime error }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `FindJobInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$findJob,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

dlnaStatus <- function(...) {

  query <- ghql::Query$new()
  query$query('dlnaStatus', '
  query dlnaStatus { dlnaStatus { ...DLNAStatus } }
fragment DLNAIP on DLNAIP { ipAddress until }
fragment DLNAStatus on DLNAStatus { running until recentIPAddresses allowedIPAddresses { ...DLNAIP } }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$dlnaStatus,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

allPerformers <- function(...) {

  query <- ghql::Query$new()
  query$query('allPerformers', '
  query allPerformers { allPerformers { ...Performer } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$allPerformers,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

version <- function(...) {

  query <- ghql::Query$new()
  query$query('version', '
  query version { version { ...Version } }
fragment Version on Version { version hash build_time }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$version,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

latestversion <- function(...) {

  query <- ghql::Query$new()
  query$query('latestversion', '
  query latestversion { latestversion { ...LatestVersion } }
fragment LatestVersion on LatestVersion { version shorthash release_date url }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$latestversion,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

setup <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('setup', '
  mutation setup($input: SetupInput!) { setup(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SetupInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$setup,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

migrate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('migrate', '
  mutation migrate($input: MigrateInput!) { migrate(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `MigrateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$migrate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

downloadFFMpeg <- function(...) {

  query <- ghql::Query$new()
  query$query('downloadFFMpeg', '
  mutation downloadFFMpeg { downloadFFMpeg }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$downloadFFMpeg,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneCreate', '
  mutation sceneCreate($input: SceneCreateInput!) { sceneCreate(input: $input) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneUpdate', '
  mutation sceneUpdate($input: SceneUpdateInput!) { sceneUpdate(input: $input) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneMerge <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneMerge', '
  mutation sceneMerge($input: SceneMergeInput!) { sceneMerge(input: $input) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneMergeInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneMerge,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkSceneUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkSceneUpdate', '
  mutation bulkSceneUpdate($input: BulkSceneUpdateInput!) { bulkSceneUpdate(input: $input) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkSceneUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkSceneUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneDestroy', '
  mutation sceneDestroy($input: SceneDestroyInput!) { sceneDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scenesDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scenesDestroy', '
  mutation scenesDestroy($input: ScenesDestroyInput!) { scenesDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScenesDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scenesDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

scenesUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scenesUpdate', '
  mutation scenesUpdate($input: [SceneUpdateInput!]!) { scenesUpdate(input: $input) { ...Scene } }
fragment VideoCaption on VideoCaption { language_code caption_type }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
fragment SceneGroup on SceneGroup { group { id name } scene_index }
fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `[SceneUpdateInput!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$scenesUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneAddO <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneAddO', '
  mutation sceneAddO($id: ID! $times: [Timestamp!]) { sceneAddO(id: $id times: $times) { ...HistoryMutationResult } }
fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneAddO,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneDeleteO <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneDeleteO', '
  mutation sceneDeleteO($id: ID! $times: [Timestamp!]) { sceneDeleteO(id: $id times: $times) { ...HistoryMutationResult } }
fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneDeleteO,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneResetO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneResetO', '
  mutation sceneResetO($id: ID!) { sceneResetO(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneResetO,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneSaveActivity <- function(id = list(), resumetime = NA, playDuration = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneSaveActivity', '
  mutation sceneSaveActivity($id: ID! $resumetime: Float $playDuration: Float) { sceneSaveActivity(id: $id resume_time: $resumetime playDuration: $playDuration) }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['resumetime']] <- resumetime
  variables[['playDuration']] <- playDuration

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneSaveActivity,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneResetActivity <- function(id = list(), resetresume = NA, resetduration = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneResetActivity', '
  mutation sceneResetActivity($id: ID! $resetresume: Boolean $resetduration: Boolean) { sceneResetActivity(id: $id reset_resume: $resetresume reset_duration: $resetduration) }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['resetresume']] <- resetresume
  variables[['resetduration']] <- resetduration

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneResetActivity,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneAddPlay <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneAddPlay', '
  mutation sceneAddPlay($id: ID! $times: [Timestamp!]) { sceneAddPlay(id: $id times: $times) { ...HistoryMutationResult } }
fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneAddPlay,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneDeletePlay <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneDeletePlay', '
  mutation sceneDeletePlay($id: ID! $times: [Timestamp!]) { sceneDeletePlay(id: $id times: $times) { ...HistoryMutationResult } }
fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneDeletePlay,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneResetPlayCount <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneResetPlayCount', '
  mutation sceneResetPlayCount($id: ID!) { sceneResetPlayCount(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneResetPlayCount,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneGenerateScreenshot <- function(id = list(), at = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneGenerateScreenshot', '
  mutation sceneGenerateScreenshot($id: ID! $at: Float) { sceneGenerateScreenshot(id: $id at: $at) }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['at']] <- at

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneGenerateScreenshot,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneMarkerCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerCreate', '
  mutation sceneMarkerCreate($input: SceneMarkerCreateInput!) { sceneMarkerCreate(input: $input) { ...SceneMarker } }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneMarkerCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneMarkerCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneMarkerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerUpdate', '
  mutation sceneMarkerUpdate($input: SceneMarkerUpdateInput!) { sceneMarkerUpdate(input: $input) { ...SceneMarker } }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SceneMarkerUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneMarkerUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkSceneMarkerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkSceneMarkerUpdate', '
  mutation bulkSceneMarkerUpdate($input: BulkSceneMarkerUpdateInput!) { bulkSceneMarkerUpdate(input: $input) { ...SceneMarker } }
fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkSceneMarkerUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkSceneMarkerUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneMarkerDestroy <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerDestroy', '
  mutation sceneMarkerDestroy($id: ID!) { sceneMarkerDestroy(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneMarkerDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneMarkersDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkersDestroy', '
  mutation sceneMarkersDestroy($ids: [ID!]!) { sceneMarkersDestroy(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneMarkersDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

sceneAssignFile <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneAssignFile', '
  mutation sceneAssignFile($input: AssignSceneFileInput!) { sceneAssignFile(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `AssignSceneFileInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$sceneAssignFile,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imageUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imageUpdate', '
  mutation imageUpdate($input: ImageUpdateInput!) { imageUpdate(input: $input) { ...Image } }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
fragment ImagePathsType on ImagePathsType { thumbnail preview }
fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ImageUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imageUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkImageUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkImageUpdate', '
  mutation bulkImageUpdate($input: BulkImageUpdateInput!) { bulkImageUpdate(input: $input) { ...Image } }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
fragment ImagePathsType on ImagePathsType { thumbnail preview }
fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkImageUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkImageUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imageDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imageDestroy', '
  mutation imageDestroy($input: ImageDestroyInput!) { imageDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ImageDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imageDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imagesDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imagesDestroy', '
  mutation imagesDestroy($input: ImagesDestroyInput!) { imagesDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ImagesDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imagesDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imagesUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imagesUpdate', '
  mutation imagesUpdate($input: [ImageUpdateInput!]!) { imagesUpdate(input: $input) { ...Image } }
fragment Fingerprint on Fingerprint { type value }
fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
fragment ImagePathsType on ImagePathsType { thumbnail preview }
fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `[ImageUpdateInput!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imagesUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imageIncrementO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('imageIncrementO', '
  mutation imageIncrementO($id: ID!) { imageIncrementO(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imageIncrementO,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imageDecrementO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('imageDecrementO', '
  mutation imageDecrementO($id: ID!) { imageDecrementO(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imageDecrementO,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

imageResetO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('imageResetO', '
  mutation imageResetO($id: ID!) { imageResetO(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$imageResetO,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleryCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryCreate', '
  mutation galleryCreate($input: GalleryCreateInput!) { galleryCreate(input: $input) { ...Gallery } }
fragment Fingerprint on Fingerprint { type value }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
fragment GalleryPathsType on GalleryPathsType { cover preview }
fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleryCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleryUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryUpdate', '
  mutation galleryUpdate($input: GalleryUpdateInput!) { galleryUpdate(input: $input) { ...Gallery } }
fragment Fingerprint on Fingerprint { type value }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
fragment GalleryPathsType on GalleryPathsType { cover preview }
fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleryUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkGalleryUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkGalleryUpdate', '
  mutation bulkGalleryUpdate($input: BulkGalleryUpdateInput!) { bulkGalleryUpdate(input: $input) { ...Gallery } }
fragment Fingerprint on Fingerprint { type value }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
fragment GalleryPathsType on GalleryPathsType { cover preview }
fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkGalleryUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkGalleryUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleryDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryDestroy', '
  mutation galleryDestroy($input: GalleryDestroyInput!) { galleryDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleryDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleriesUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleriesUpdate', '
  mutation galleriesUpdate($input: [GalleryUpdateInput!]!) { galleriesUpdate(input: $input) { ...Gallery } }
fragment Fingerprint on Fingerprint { type value }
fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
fragment GalleryPathsType on GalleryPathsType { cover preview }
fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `[GalleryUpdateInput!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleriesUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

addGalleryImages <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('addGalleryImages', '
  mutation addGalleryImages($input: GalleryAddInput!) { addGalleryImages(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryAddInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$addGalleryImages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

removeGalleryImages <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('removeGalleryImages', '
  mutation removeGalleryImages($input: GalleryRemoveInput!) { removeGalleryImages(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryRemoveInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$removeGalleryImages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

setGalleryCover <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('setGalleryCover', '
  mutation setGalleryCover($input: GallerySetCoverInput!) { setGalleryCover(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GallerySetCoverInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$setGalleryCover,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

resetGalleryCover <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('resetGalleryCover', '
  mutation resetGalleryCover($input: GalleryResetCoverInput!) { resetGalleryCover(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryResetCoverInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$resetGalleryCover,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleryChapterCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryChapterCreate', '
  mutation galleryChapterCreate($input: GalleryChapterCreateInput!) { galleryChapterCreate(input: $input) { ...GalleryChapter } }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryChapterCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleryChapterCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleryChapterUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryChapterUpdate', '
  mutation galleryChapterUpdate($input: GalleryChapterUpdateInput!) { galleryChapterUpdate(input: $input) { ...GalleryChapter } }
fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GalleryChapterUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleryChapterUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

galleryChapterDestroy <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('galleryChapterDestroy', '
  mutation galleryChapterDestroy($id: ID!) { galleryChapterDestroy(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$galleryChapterDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

performerCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerCreate', '
  mutation performerCreate($input: PerformerCreateInput!) { performerCreate(input: $input) { ...Performer } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `PerformerCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$performerCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

performerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerUpdate', '
  mutation performerUpdate($input: PerformerUpdateInput!) { performerUpdate(input: $input) { ...Performer } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `PerformerUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$performerUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

performerDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerDestroy', '
  mutation performerDestroy($input: PerformerDestroyInput!) { performerDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `PerformerDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$performerDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

performersDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('performersDestroy', '
  mutation performersDestroy($ids: [ID!]!) { performersDestroy(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$performersDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkPerformerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkPerformerUpdate', '
  mutation bulkPerformerUpdate($input: BulkPerformerUpdateInput!) { bulkPerformerUpdate(input: $input) { ...Performer } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkPerformerUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkPerformerUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

performerMerge <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerMerge', '
  mutation performerMerge($input: PerformerMergeInput!) { performerMerge(input: $input) { ...Performer } }
fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `PerformerMergeInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$performerMerge,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

studioCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('studioCreate', '
  mutation studioCreate($input: StudioCreateInput!) { studioCreate(input: $input) { ...Studio } }
fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StudioCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$studioCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

studioUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('studioUpdate', '
  mutation studioUpdate($input: StudioUpdateInput!) { studioUpdate(input: $input) { ...Studio } }
fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StudioUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$studioUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

studioDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('studioDestroy', '
  mutation studioDestroy($input: StudioDestroyInput!) { studioDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StudioDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$studioDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

studiosDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('studiosDestroy', '
  mutation studiosDestroy($ids: [ID!]!) { studiosDestroy(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$studiosDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkStudioUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkStudioUpdate', '
  mutation bulkStudioUpdate($input: BulkStudioUpdateInput!) { bulkStudioUpdate(input: $input) { ...Studio } }
fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkStudioUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkStudioUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

groupCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('groupCreate', '
  mutation groupCreate($input: GroupCreateInput!) { groupCreate(input: $input) { ...Group } }
fragment GroupDescription on GroupDescription { group { id name } description }
fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GroupCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$groupCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

groupUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('groupUpdate', '
  mutation groupUpdate($input: GroupUpdateInput!) { groupUpdate(input: $input) { ...Group } }
fragment GroupDescription on GroupDescription { group { id name } description }
fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GroupUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$groupUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

groupDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('groupDestroy', '
  mutation groupDestroy($input: GroupDestroyInput!) { groupDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GroupDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$groupDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

groupsDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('groupsDestroy', '
  mutation groupsDestroy($ids: [ID!]!) { groupsDestroy(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$groupsDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkGroupUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkGroupUpdate', '
  mutation bulkGroupUpdate($input: BulkGroupUpdateInput!) { bulkGroupUpdate(input: $input) { ...Group } }
fragment GroupDescription on GroupDescription { group { id name } description }
fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkGroupUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkGroupUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

addGroupSubGroups <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('addGroupSubGroups', '
  mutation addGroupSubGroups($input: GroupSubGroupAddInput!) { addGroupSubGroups(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GroupSubGroupAddInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$addGroupSubGroups,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

removeGroupSubGroups <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('removeGroupSubGroups', '
  mutation removeGroupSubGroups($input: GroupSubGroupRemoveInput!) { removeGroupSubGroups(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GroupSubGroupRemoveInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$removeGroupSubGroups,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

reorderSubGroups <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('reorderSubGroups', '
  mutation reorderSubGroups($input: ReorderSubGroupsInput!) { reorderSubGroups(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ReorderSubGroupsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$reorderSubGroups,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

tagCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagCreate', '
  mutation tagCreate($input: TagCreateInput!) { tagCreate(input: $input) { ...Tag } }
fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `TagCreateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$tagCreate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

tagUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagUpdate', '
  mutation tagUpdate($input: TagUpdateInput!) { tagUpdate(input: $input) { ...Tag } }
fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `TagUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$tagUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

tagDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagDestroy', '
  mutation tagDestroy($input: TagDestroyInput!) { tagDestroy(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `TagDestroyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$tagDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

tagsDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('tagsDestroy', '
  mutation tagsDestroy($ids: [ID!]!) { tagsDestroy(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$tagsDestroy,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

tagsMerge <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagsMerge', '
  mutation tagsMerge($input: TagsMergeInput!) { tagsMerge(input: $input) { ...Tag } }
fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `TagsMergeInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$tagsMerge,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

bulkTagUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkTagUpdate', '
  mutation bulkTagUpdate($input: BulkTagUpdateInput!) { bulkTagUpdate(input: $input) { ...Tag } }
fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BulkTagUpdateInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$bulkTagUpdate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

moveFiles <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('moveFiles', '
  mutation moveFiles($input: MoveFilesInput!) { moveFiles(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `MoveFilesInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$moveFiles,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

deleteFiles <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('deleteFiles', '
  mutation deleteFiles($ids: [ID!]!) { deleteFiles(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$deleteFiles,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

destroyFiles <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('destroyFiles', '
  mutation destroyFiles($ids: [ID!]!) { destroyFiles(ids: $ids) }
  ')

  variables <- list()
  variables[['ids']] <- ids

  if (is.null(ids) || (length(ids) == 1L && is.atomic(ids) && is.na(ids))) {
  stop("`ids` is required by GraphQL type `[ID!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$destroyFiles,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

fileSetFingerprints <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('fileSetFingerprints', '
  mutation fileSetFingerprints($input: FileSetFingerprintsInput!) { fileSetFingerprints(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `FileSetFingerprintsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$fileSetFingerprints,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

revealFileInFileManager <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('revealFileInFileManager', '
  mutation revealFileInFileManager($id: ID!) { revealFileInFileManager(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$revealFileInFileManager,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

revealFolderInFileManager <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('revealFolderInFileManager', '
  mutation revealFolderInFileManager($id: ID!) { revealFolderInFileManager(id: $id) }
  ')

  variables <- list()
  variables[['id']] <- id

  if (is.null(id) || (length(id) == 1L && is.atomic(id) && is.na(id)) || (is.list(id) && length(id) == 0L)) {
  stop("`id` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$revealFolderInFileManager,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

saveFilter <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('saveFilter', '
  mutation saveFilter($input: SaveFilterInput!) { saveFilter(input: $input) { ...SavedFilter } }
fragment SavedFindFilterType on SavedFindFilterType { q page per_page sort direction }
fragment SavedFilter on SavedFilter { id mode name find_filter { ...SavedFindFilterType } object_filter ui_options }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `SaveFilterInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$saveFilter,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

destroySavedFilter <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('destroySavedFilter', '
  mutation destroySavedFilter($input: DestroyFilterInput!) { destroySavedFilter(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `DestroyFilterInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$destroySavedFilter,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureGeneral <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureGeneral', '
  mutation configureGeneral($input: ConfigGeneralInput!) { configureGeneral(input: $input) { ...ConfigGeneralResult } }
fragment StashConfig on StashConfig { path excludeVideo excludeImage }
fragment StashBox on StashBox { endpoint api_key name max_requests_per_minute }
fragment PackageSource on PackageSource { name url local_path }
fragment ConfigGeneralResult on ConfigGeneralResult { stashes { ...StashConfig } databasePath backupDirectoryPath deleteTrashPath generatedPath metadataPath configFilePath scrapersPath pluginsPath cachePath blobsPath blobsStorage ffmpegPath ffprobePath calculateMD5 videoFileNamingAlgorithm parallelTasks previewAudio previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset transcodeHardwareAcceleration maxTranscodeSize maxStreamingTranscodeSize transcodeInputArgs transcodeOutputArgs liveTranscodeInputArgs liveTranscodeOutputArgs drawFunscriptHeatmapRange writeImageThumbnails createImageClipsFromVideos apiKey username password maxSessionAge logFile logOut logLevel logAccess logFileMaxSize useCustomSpriteInterval spriteInterval minimumSprites maximumSprites spriteScreenshotSize videoExtensions imageExtensions galleryExtensions createGalleriesFromFolders galleryCoverRegex excludes imageExcludes customPerformerImageLocation stashBoxes { ...StashBox } pythonPath scraperPackageSources { ...PackageSource } pluginPackageSources { ...PackageSource } }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ConfigGeneralInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureGeneral,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureInterface <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureInterface', '
  mutation configureInterface($input: ConfigInterfaceInput!) { configureInterface(input: $input) { ...ConfigInterfaceResult } }
fragment ConfigImageLightboxResult on ConfigImageLightboxResult { slideshowDelay displayMode scaleUp resetZoomOnNav scrollMode scrollAttemptsBeforeChange disableAnimation }
fragment ConfigDisableDropdownCreate on ConfigDisableDropdownCreate { performer tag studio movie gallery }
fragment ConfigInterfaceResult on ConfigInterfaceResult { sfwContentMode menuItems soundOnPreview wallShowTitle wallPlayback showScrubber maximumLoopDuration noBrowser notificationsEnabled autostartVideo autostartVideoOnPlaySelected continuePlaylistDefault showStudioAsText css cssEnabled javascript javascriptEnabled customLocales customLocalesEnabled disableCustomizations language imageLightbox { ...ConfigImageLightboxResult } disableDropdownCreate { ...ConfigDisableDropdownCreate } handyKey funscriptOffset useStashHostedFunscript }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ConfigInterfaceInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureInterface,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureDLNA <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureDLNA', '
  mutation configureDLNA($input: ConfigDLNAInput!) { configureDLNA(input: $input) { ...ConfigDLNAResult } }
fragment ConfigDLNAResult on ConfigDLNAResult { serverName enabled port whitelistedIPs interfaces videoSortOrder }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ConfigDLNAInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureDLNA,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureScraping <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureScraping', '
  mutation configureScraping($input: ConfigScrapingInput!) { configureScraping(input: $input) { ...ConfigScrapingResult } }
fragment ConfigScrapingResult on ConfigScrapingResult { scraperUserAgent scraperCDPPath scraperCertCheck excludeTagPatterns }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ConfigScrapingInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureScraping,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureDefaults <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureDefaults', '
  mutation configureDefaults($input: ConfigDefaultSettingsInput!) { configureDefaults(input: $input) { ...ConfigDefaultSettingsResult } }
fragment ScanMetadataOptions on ScanMetadataOptions { rescan scanGenerateCovers scanGeneratePreviews scanGenerateImagePreviews scanGenerateSprites scanGeneratePhashes scanGenerateImagePhashes scanGenerateThumbnails scanGenerateClipPreviews }
fragment ScraperSource on ScraperSource { stash_box_endpoint scraper_id }
fragment IdentifyFieldOptions on IdentifyFieldOptions { field strategy createMissing }
fragment IdentifyMetadataOptions on IdentifyMetadataOptions { fieldOptions { ...IdentifyFieldOptions } setCoverImage setOrganized performerGenders skipMultipleMatches skipMultipleMatchTag skipSingleNamePerformers skipSingleNamePerformerTag }
fragment IdentifySource on IdentifySource { source { ...ScraperSource } options { ...IdentifyMetadataOptions } }
fragment IdentifyMetadataTaskOptions on IdentifyMetadataTaskOptions { sources { ...IdentifySource } options { ...IdentifyMetadataOptions } }
fragment AutoTagMetadataOptions on AutoTagMetadataOptions { performers studios tags }
fragment GeneratePreviewOptions on GeneratePreviewOptions { previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset }
fragment GenerateMetadataOptions on GenerateMetadataOptions { covers sprites previews imagePreviews previewOptions { ...GeneratePreviewOptions } markers markerImagePreviews markerScreenshots transcodes phashes interactiveHeatmapsSpeeds imageThumbnails clipPreviews }
fragment ConfigDefaultSettingsResult on ConfigDefaultSettingsResult { scan { ...ScanMetadataOptions } identify { ...IdentifyMetadataTaskOptions } autoTag { ...AutoTagMetadataOptions } generate { ...GenerateMetadataOptions } deleteFile deleteGenerated }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ConfigDefaultSettingsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureDefaults,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configurePlugin <- function(pluginid = list(), input = list(), ...) {

  query <- ghql::Query$new()
  query$query('configurePlugin', '
  mutation configurePlugin($pluginid: ID! $input: Map!) { configurePlugin(plugin_id: $pluginid input: $input) }
  ')

  variables <- list()
  variables[['pluginid']] <- pluginid
  variables[['input']] <- input

  if (is.null(pluginid) || (length(pluginid) == 1L && is.atomic(pluginid) && is.na(pluginid)) || (is.list(pluginid) && length(pluginid) == 0L)) {
  stop("`pluginid` is required by GraphQL type `ID!`.", call. = FALSE)
}
  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input)) || (is.list(input) && length(input) == 0L)) {
  stop("`input` is required by GraphQL type `Map!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configurePlugin,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureUI <- function(input = NA, partial = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureUI', '
  mutation configureUI($input: Map $partial: Map) { configureUI(input: $input partial: $partial) }
  ')

  variables <- list()
  variables[['input']] <- input
  variables[['partial']] <- partial

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureUI,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

configureUISetting <- function(key = list(), value = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureUISetting', '
  mutation configureUISetting($key: String! $value: Any) { configureUISetting(key: $key value: $value) }
  ')

  variables <- list()
  variables[['key']] <- key
  variables[['value']] <- value

  if (is.null(key) || (length(key) == 1L && is.atomic(key) && is.na(key)) || (is.list(key) && length(key) == 0L)) {
  stop("`key` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$configureUISetting,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

generateAPIKey <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('generateAPIKey', '
  mutation generateAPIKey($input: GenerateAPIKeyInput!) { generateAPIKey(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GenerateAPIKeyInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$generateAPIKey,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

exportObjects <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('exportObjects', '
  mutation exportObjects($input: ExportObjectsInput!) { exportObjects(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ExportObjectsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$exportObjects,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

importObjects <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('importObjects', '
  mutation importObjects($input: ImportObjectsInput!) { importObjects(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ImportObjectsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$importObjects,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataImport <- function(...) {

  query <- ghql::Query$new()
  query$query('metadataImport', '
  mutation metadataImport { metadataImport }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataImport,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataExport <- function(...) {

  query <- ghql::Query$new()
  query$query('metadataExport', '
  mutation metadataExport { metadataExport }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataExport,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataScan <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataScan', '
  mutation metadataScan($input: ScanMetadataInput!) { metadataScan(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `ScanMetadataInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataScan,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataGenerate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataGenerate', '
  mutation metadataGenerate($input: GenerateMetadataInput!) { metadataGenerate(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `GenerateMetadataInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataGenerate,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataAutoTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataAutoTag', '
  mutation metadataAutoTag($input: AutoTagMetadataInput!) { metadataAutoTag(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `AutoTagMetadataInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataAutoTag,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataClean <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataClean', '
  mutation metadataClean($input: CleanMetadataInput!) { metadataClean(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `CleanMetadataInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataClean,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataCleanGenerated <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataCleanGenerated', '
  mutation metadataCleanGenerated($input: CleanGeneratedInput!) { metadataCleanGenerated(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `CleanGeneratedInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataCleanGenerated,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

metadataIdentify <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataIdentify', '
  mutation metadataIdentify($input: IdentifyMetadataInput!) { metadataIdentify(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `IdentifyMetadataInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$metadataIdentify,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

migrateHashNaming <- function(...) {

  query <- ghql::Query$new()
  query$query('migrateHashNaming', '
  mutation migrateHashNaming { migrateHashNaming }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$migrateHashNaming,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

migrateSceneScreenshots <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('migrateSceneScreenshots', '
  mutation migrateSceneScreenshots($input: MigrateSceneScreenshotsInput!) { migrateSceneScreenshots(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `MigrateSceneScreenshotsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$migrateSceneScreenshots,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

migrateBlobs <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('migrateBlobs', '
  mutation migrateBlobs($input: MigrateBlobsInput!) { migrateBlobs(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `MigrateBlobsInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$migrateBlobs,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

anonymiseDatabase <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('anonymiseDatabase', '
  mutation anonymiseDatabase($input: AnonymiseDatabaseInput!) { anonymiseDatabase(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `AnonymiseDatabaseInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$anonymiseDatabase,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

optimiseDatabase <- function(...) {

  query <- ghql::Query$new()
  query$query('optimiseDatabase', '
  mutation optimiseDatabase { optimiseDatabase }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$optimiseDatabase,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

reloadScrapers <- function(...) {

  query <- ghql::Query$new()
  query$query('reloadScrapers', '
  mutation reloadScrapers { reloadScrapers }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$reloadScrapers,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

setPluginsEnabled <- function(enabledMap = list(), ...) {

  query <- ghql::Query$new()
  query$query('setPluginsEnabled', '
  mutation setPluginsEnabled($enabledMap: BoolMap!) { setPluginsEnabled(enabledMap: $enabledMap) }
  ')

  variables <- list()
  variables[['enabledMap']] <- enabledMap

  if (is.null(enabledMap) || (length(enabledMap) == 1L && is.atomic(enabledMap) && is.na(enabledMap)) || (is.list(enabledMap) && length(enabledMap) == 0L)) {
  stop("`enabledMap` is required by GraphQL type `BoolMap!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$setPluginsEnabled,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

runPluginTask <- function(pluginid = list(), taskname = NA, description = NA, args = NA, argsmap = NA, ...) {

  query <- ghql::Query$new()
  query$query('runPluginTask', '
  mutation runPluginTask($pluginid: ID! $taskname: String $description: String $args: [PluginArgInput!] $argsmap: Map) { runPluginTask(plugin_id: $pluginid task_name: $taskname description: $description args: $args args_map: $argsmap) }
  ')

  variables <- list()
  variables[['pluginid']] <- pluginid
  variables[['taskname']] <- taskname
  variables[['description']] <- description
  variables[['args']] <- args
  variables[['argsmap']] <- argsmap

  if (is.null(pluginid) || (length(pluginid) == 1L && is.atomic(pluginid) && is.na(pluginid)) || (is.list(pluginid) && length(pluginid) == 0L)) {
  stop("`pluginid` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$runPluginTask,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

runPluginOperation <- function(pluginid = list(), args = NA, ...) {

  query <- ghql::Query$new()
  query$query('runPluginOperation', '
  mutation runPluginOperation($pluginid: ID! $args: Map) { runPluginOperation(plugin_id: $pluginid args: $args) }
  ')

  variables <- list()
  variables[['pluginid']] <- pluginid
  variables[['args']] <- args

  if (is.null(pluginid) || (length(pluginid) == 1L && is.atomic(pluginid) && is.na(pluginid)) || (is.list(pluginid) && length(pluginid) == 0L)) {
  stop("`pluginid` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$runPluginOperation,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

reloadPlugins <- function(...) {

  query <- ghql::Query$new()
  query$query('reloadPlugins', '
  mutation reloadPlugins { reloadPlugins }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$reloadPlugins,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

installPackages <- function(type = NA, packages = NA, ...) {

  query <- ghql::Query$new()
  query$query('installPackages', '
  mutation installPackages($type: PackageType! $packages: [PackageSpecInput!]!) { installPackages(type: $type packages: $packages) }
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['packages']] <- packages

  if (is.null(type) || (length(type) == 1L && is.atomic(type) && is.na(type))) {
  stop("`type` is required by GraphQL type `PackageType!`.", call. = FALSE)
}
  if (is.null(packages) || (length(packages) == 1L && is.atomic(packages) && is.na(packages))) {
  stop("`packages` is required by GraphQL type `[PackageSpecInput!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$installPackages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

updatePackages <- function(type = NA, packages = NA, ...) {

  query <- ghql::Query$new()
  query$query('updatePackages', '
  mutation updatePackages($type: PackageType! $packages: [PackageSpecInput!]) { updatePackages(type: $type packages: $packages) }
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['packages']] <- packages

  if (is.null(type) || (length(type) == 1L && is.atomic(type) && is.na(type))) {
  stop("`type` is required by GraphQL type `PackageType!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$updatePackages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

uninstallPackages <- function(type = NA, packages = NA, ...) {

  query <- ghql::Query$new()
  query$query('uninstallPackages', '
  mutation uninstallPackages($type: PackageType! $packages: [PackageSpecInput!]!) { uninstallPackages(type: $type packages: $packages) }
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['packages']] <- packages

  if (is.null(type) || (length(type) == 1L && is.atomic(type) && is.na(type))) {
  stop("`type` is required by GraphQL type `PackageType!`.", call. = FALSE)
}
  if (is.null(packages) || (length(packages) == 1L && is.atomic(packages) && is.na(packages))) {
  stop("`packages` is required by GraphQL type `[PackageSpecInput!]!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$uninstallPackages,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

stopJob <- function(jobid = list(), ...) {

  query <- ghql::Query$new()
  query$query('stopJob', '
  mutation stopJob($jobid: ID!) { stopJob(job_id: $jobid) }
  ')

  variables <- list()
  variables[['jobid']] <- jobid

  if (is.null(jobid) || (length(jobid) == 1L && is.atomic(jobid) && is.na(jobid)) || (is.list(jobid) && length(jobid) == 0L)) {
  stop("`jobid` is required by GraphQL type `ID!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$stopJob,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

stopAllJobs <- function(...) {

  query <- ghql::Query$new()
  query$query('stopAllJobs', '
  mutation stopAllJobs { stopAllJobs }
  ')

  variables <- list()

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$stopAllJobs,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

submitStashBoxFingerprints <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('submitStashBoxFingerprints', '
  mutation submitStashBoxFingerprints($input: StashBoxFingerprintSubmissionInput!) { submitStashBoxFingerprints(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxFingerprintSubmissionInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$submitStashBoxFingerprints,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

submitStashBoxSceneDraft <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('submitStashBoxSceneDraft', '
  mutation submitStashBoxSceneDraft($input: StashBoxDraftSubmissionInput!) { submitStashBoxSceneDraft(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxDraftSubmissionInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$submitStashBoxSceneDraft,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

submitStashBoxPerformerDraft <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('submitStashBoxPerformerDraft', '
  mutation submitStashBoxPerformerDraft($input: StashBoxDraftSubmissionInput!) { submitStashBoxPerformerDraft(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxDraftSubmissionInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$submitStashBoxPerformerDraft,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

backupDatabase <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('backupDatabase', '
  mutation backupDatabase($input: BackupDatabaseInput!) { backupDatabase(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `BackupDatabaseInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$backupDatabase,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

querySQL <- function(sql = list(), args = NA, ...) {

  query <- ghql::Query$new()
  query$query('querySQL', '
  mutation querySQL($sql: String! $args: [Any]) { querySQL(sql: $sql args: $args) { ...SQLQueryResult } }
fragment SQLQueryResult on SQLQueryResult { columns rows }
  ')

  variables <- list()
  variables[['sql']] <- sql
  variables[['args']] <- args

  if (is.null(sql) || (length(sql) == 1L && is.atomic(sql) && is.na(sql)) || (is.list(sql) && length(sql) == 0L)) {
  stop("`sql` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$querySQL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

execSQL <- function(sql = list(), args = NA, ...) {

  query <- ghql::Query$new()
  query$query('execSQL', '
  mutation execSQL($sql: String! $args: [Any]) { execSQL(sql: $sql args: $args) { ...SQLExecResult } }
fragment SQLExecResult on SQLExecResult { rows_affected last_insert_id }
  ')

  variables <- list()
  variables[['sql']] <- sql
  variables[['args']] <- args

  if (is.null(sql) || (length(sql) == 1L && is.atomic(sql) && is.na(sql)) || (is.list(sql) && length(sql) == 0L)) {
  stop("`sql` is required by GraphQL type `String!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$execSQL,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

stashBoxBatchPerformerTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('stashBoxBatchPerformerTag', '
  mutation stashBoxBatchPerformerTag($input: StashBoxBatchTagInput!) { stashBoxBatchPerformerTag(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxBatchTagInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$stashBoxBatchPerformerTag,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

stashBoxBatchStudioTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('stashBoxBatchStudioTag', '
  mutation stashBoxBatchStudioTag($input: StashBoxBatchTagInput!) { stashBoxBatchStudioTag(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxBatchTagInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$stashBoxBatchStudioTag,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

stashBoxBatchTagTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('stashBoxBatchTagTag', '
  mutation stashBoxBatchTagTag($input: StashBoxBatchTagInput!) { stashBoxBatchTagTag(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `StashBoxBatchTagInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$stashBoxBatchTagTag,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

enableDLNA <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('enableDLNA', '
  mutation enableDLNA($input: EnableDLNAInput!) { enableDLNA(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `EnableDLNAInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$enableDLNA,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

disableDLNA <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('disableDLNA', '
  mutation disableDLNA($input: DisableDLNAInput!) { disableDLNA(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `DisableDLNAInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$disableDLNA,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

addTempDLNAIP <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('addTempDLNAIP', '
  mutation addTempDLNAIP($input: AddTempDLNAIPInput!) { addTempDLNAIP(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `AddTempDLNAIPInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$addTempDLNAIP,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

removeTempDLNAIP <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('removeTempDLNAIP', '
  mutation removeTempDLNAIP($input: RemoveTempDLNAIPInput!) { removeTempDLNAIP(input: $input) }
  ')

  variables <- list()
  variables[['input']] <- input

  if (is.null(input) || (length(input) == 1L && is.atomic(input) && is.na(input))) {
  stop("`input` is required by GraphQL type `RemoveTempDLNAIPInput!`.", call. = FALSE)
}

  return_default <- NA_character_
  options <- prepare_stash_query_options(list(...), return_default)
  field <- options$field
  response <- options$response
  progress_bar <- options$progress_bar
  res <- execute_query(
    query = query$queries$removeTempDLNAIP,
    variables = variables,
    connection = get_stash_connection(),
    return_default = return_default,
    field = field,
    response = response,
    progress_bar = progress_bar
  )

  return(res)
}

