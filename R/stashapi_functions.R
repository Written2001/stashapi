#' Call GraphQL operation: setup
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
setup <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('setup', '
  mutation setup($input: SetupInput!) { setup(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$setup, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: migrate
#' @description Migrates the schema to the required version. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
migrate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('migrate', '
  mutation migrate($input: MigrateInput!) { migrate(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$migrate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: downloadFFMpeg
#' @description Downloads and installs ffmpeg and ffprobe binaries into the configuration directory. Returns the job ID.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
downloadFFMpeg <- function(...) {

  query <- ghql::Query$new()
  query$query('downloadFFMpeg', '
  mutation downloadFFMpeg { downloadFFMpeg }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$downloadFFMpeg, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneCreate', '
  mutation sceneCreate($input: SceneCreateInput!) { sceneCreate(input: $input) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneUpdate', '
  mutation sceneUpdate($input: SceneUpdateInput!) { sceneUpdate(input: $input) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneMerge
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneMerge <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneMerge', '
  mutation sceneMerge($input: SceneMergeInput!) { sceneMerge(input: $input) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneMerge, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkSceneUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkSceneUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkSceneUpdate', '
  mutation bulkSceneUpdate($input: BulkSceneUpdateInput!) { bulkSceneUpdate(input: $input) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkSceneUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneDestroy', '
  mutation sceneDestroy($input: SceneDestroyInput!) { sceneDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scenesDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scenesDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scenesDestroy', '
  mutation scenesDestroy($input: ScenesDestroyInput!) { scenesDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scenesDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scenesUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scenesUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scenesUpdate', '
  mutation scenesUpdate($input: [SceneUpdateInput!]!) { scenesUpdate(input: $input) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scenesUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneAddO
#' @description Increments the o-counter for a scene. Uses the current time if none provided.
#' @param id   See the Playground for further details.
#' @param times   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneAddO <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneAddO', '
  mutation sceneAddO($id: ID! $times: [Timestamp!]) { sceneAddO(id: $id times: $times) { ...HistoryMutationResult } }
  fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneAddO, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneDeleteO
#' @description Decrements the o-counter for a scene, removing the last recorded time if specific time not provided. Returns the new value
#' @param id   See the Playground for further details.
#' @param times   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneDeleteO <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneDeleteO', '
  mutation sceneDeleteO($id: ID! $times: [Timestamp!]) { sceneDeleteO(id: $id times: $times) { ...HistoryMutationResult } }
  fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneDeleteO, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneResetO
#' @description Resets the o-counter for a scene to 0. Returns the new value
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneResetO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneResetO', '
  mutation sceneResetO($id: ID!) { sceneResetO(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneResetO, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneSaveActivity
#' @description Sets the resume time point (if provided) and adds the provided duration to the scene's play duration
#' @param id   See the Playground for further details.
#' @param resumetime   See the Playground for further details.
#' @param playDuration   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneSaveActivity <- function(id = list(), resumetime = NA, playDuration = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneSaveActivity', '
  mutation sceneSaveActivity($id: ID! $resumetime: Float $playDuration: Float) { sceneSaveActivity(id: $id resume_time: $resumetime playDuration: $playDuration) }
  
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['resumetime']] <- resumetime
  variables[['playDuration']] <- playDuration

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneSaveActivity, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneResetActivity
#' @description Resets the resume time point and play duration
#' @param id   See the Playground for further details.
#' @param resetresume   See the Playground for further details.
#' @param resetduration   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneResetActivity <- function(id = list(), resetresume = NA, resetduration = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneResetActivity', '
  mutation sceneResetActivity($id: ID! $resetresume: Boolean $resetduration: Boolean) { sceneResetActivity(id: $id reset_resume: $resetresume reset_duration: $resetduration) }
  
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['resetresume']] <- resetresume
  variables[['resetduration']] <- resetduration

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneResetActivity, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneAddPlay
#' @description Increments the play count for the scene. Uses the current time if none provided.
#' @param id   See the Playground for further details.
#' @param times   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneAddPlay <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneAddPlay', '
  mutation sceneAddPlay($id: ID! $times: [Timestamp!]) { sceneAddPlay(id: $id times: $times) { ...HistoryMutationResult } }
  fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneAddPlay, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneDeletePlay
#' @description Decrements the play count for the scene, removing the specific times or the last recorded time if not provided.
#' @param id   See the Playground for further details.
#' @param times   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneDeletePlay <- function(id = list(), times = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneDeletePlay', '
  mutation sceneDeletePlay($id: ID! $times: [Timestamp!]) { sceneDeletePlay(id: $id times: $times) { ...HistoryMutationResult } }
  fragment HistoryMutationResult on HistoryMutationResult { count history }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['times']] <- times

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneDeletePlay, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneResetPlayCount
#' @description Resets the play count for a scene to 0. Returns the new play count value.
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneResetPlayCount <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneResetPlayCount', '
  mutation sceneResetPlayCount($id: ID!) { sceneResetPlayCount(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneResetPlayCount, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneGenerateScreenshot
#' @description Generates screenshot at specified time in seconds. Leave empty to generate default screenshot
#' @param id   See the Playground for further details.
#' @param at   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneGenerateScreenshot <- function(id = list(), at = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneGenerateScreenshot', '
  mutation sceneGenerateScreenshot($id: ID! $at: Float) { sceneGenerateScreenshot(id: $id at: $at) }
  
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['at']] <- at

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneGenerateScreenshot, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneMarkerCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneMarkerCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerCreate', '
  mutation sceneMarkerCreate($input: SceneMarkerCreateInput!) { sceneMarkerCreate(input: $input) { ...SceneMarker } }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneMarkerCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneMarkerUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneMarkerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerUpdate', '
  mutation sceneMarkerUpdate($input: SceneMarkerUpdateInput!) { sceneMarkerUpdate(input: $input) { ...SceneMarker } }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneMarkerUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkSceneMarkerUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkSceneMarkerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkSceneMarkerUpdate', '
  mutation bulkSceneMarkerUpdate($input: BulkSceneMarkerUpdateInput!) { bulkSceneMarkerUpdate(input: $input) { ...SceneMarker } }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkSceneMarkerUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneMarkerDestroy
#' 
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneMarkerDestroy <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerDestroy', '
  mutation sceneMarkerDestroy($id: ID!) { sceneMarkerDestroy(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneMarkerDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneMarkersDestroy
#' 
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneMarkersDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkersDestroy', '
  mutation sceneMarkersDestroy($ids: [ID!]!) { sceneMarkersDestroy(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneMarkersDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneAssignFile
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneAssignFile <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneAssignFile', '
  mutation sceneAssignFile($input: AssignSceneFileInput!) { sceneAssignFile(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneAssignFile, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imageUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imageUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imageUpdate', '
  mutation imageUpdate($input: ImageUpdateInput!) { imageUpdate(input: $input) { ...Image } }
  fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
  fragment ImagePathsType on ImagePathsType { thumbnail preview }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imageUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkImageUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkImageUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkImageUpdate', '
  mutation bulkImageUpdate($input: BulkImageUpdateInput!) { bulkImageUpdate(input: $input) { ...Image } }
  fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
  fragment ImagePathsType on ImagePathsType { thumbnail preview }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkImageUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imageDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imageDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imageDestroy', '
  mutation imageDestroy($input: ImageDestroyInput!) { imageDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imageDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imagesDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imagesDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imagesDestroy', '
  mutation imagesDestroy($input: ImagesDestroyInput!) { imagesDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imagesDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imagesUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imagesUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('imagesUpdate', '
  mutation imagesUpdate($input: [ImageUpdateInput!]!) { imagesUpdate(input: $input) { ...Image } }
  fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
  fragment ImagePathsType on ImagePathsType { thumbnail preview }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imagesUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imageIncrementO
#' @description Increments the o-counter for an image. Returns the new value
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imageIncrementO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('imageIncrementO', '
  mutation imageIncrementO($id: ID!) { imageIncrementO(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imageIncrementO, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imageDecrementO
#' @description Decrements the o-counter for an image. Returns the new value
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imageDecrementO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('imageDecrementO', '
  mutation imageDecrementO($id: ID!) { imageDecrementO(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imageDecrementO, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: imageResetO
#' @description Resets the o-counter for a image to 0. Returns the new value
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
imageResetO <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('imageResetO', '
  mutation imageResetO($id: ID!) { imageResetO(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$imageResetO, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleryCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleryCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryCreate', '
  mutation galleryCreate($input: GalleryCreateInput!) { galleryCreate(input: $input) { ...Gallery } }
  fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  fragment GalleryPathsType on GalleryPathsType { cover preview }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleryCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleryUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleryUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryUpdate', '
  mutation galleryUpdate($input: GalleryUpdateInput!) { galleryUpdate(input: $input) { ...Gallery } }
  fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  fragment GalleryPathsType on GalleryPathsType { cover preview }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleryUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkGalleryUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkGalleryUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkGalleryUpdate', '
  mutation bulkGalleryUpdate($input: BulkGalleryUpdateInput!) { bulkGalleryUpdate(input: $input) { ...Gallery } }
  fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  fragment GalleryPathsType on GalleryPathsType { cover preview }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkGalleryUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleryDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleryDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryDestroy', '
  mutation galleryDestroy($input: GalleryDestroyInput!) { galleryDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleryDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleriesUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleriesUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleriesUpdate', '
  mutation galleriesUpdate($input: [GalleryUpdateInput!]!) { galleriesUpdate(input: $input) { ...Gallery } }
  fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  fragment GalleryPathsType on GalleryPathsType { cover preview }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleriesUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: addGalleryImages
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
addGalleryImages <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('addGalleryImages', '
  mutation addGalleryImages($input: GalleryAddInput!) { addGalleryImages(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$addGalleryImages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: removeGalleryImages
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
removeGalleryImages <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('removeGalleryImages', '
  mutation removeGalleryImages($input: GalleryRemoveInput!) { removeGalleryImages(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$removeGalleryImages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: setGalleryCover
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
setGalleryCover <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('setGalleryCover', '
  mutation setGalleryCover($input: GallerySetCoverInput!) { setGalleryCover(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$setGalleryCover, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: resetGalleryCover
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
resetGalleryCover <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('resetGalleryCover', '
  mutation resetGalleryCover($input: GalleryResetCoverInput!) { resetGalleryCover(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$resetGalleryCover, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleryChapterCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleryChapterCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryChapterCreate', '
  mutation galleryChapterCreate($input: GalleryChapterCreateInput!) { galleryChapterCreate(input: $input) { ...GalleryChapter } }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleryChapterCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleryChapterUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleryChapterUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('galleryChapterUpdate', '
  mutation galleryChapterUpdate($input: GalleryChapterUpdateInput!) { galleryChapterUpdate(input: $input) { ...GalleryChapter } }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleryChapterUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: galleryChapterDestroy
#' 
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
galleryChapterDestroy <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('galleryChapterDestroy', '
  mutation galleryChapterDestroy($id: ID!) { galleryChapterDestroy(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$galleryChapterDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: performerCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
performerCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerCreate', '
  mutation performerCreate($input: PerformerCreateInput!) { performerCreate(input: $input) { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$performerCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: performerUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
performerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerUpdate', '
  mutation performerUpdate($input: PerformerUpdateInput!) { performerUpdate(input: $input) { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$performerUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: performerDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
performerDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerDestroy', '
  mutation performerDestroy($input: PerformerDestroyInput!) { performerDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$performerDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: performersDestroy
#' 
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
performersDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('performersDestroy', '
  mutation performersDestroy($ids: [ID!]!) { performersDestroy(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$performersDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkPerformerUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkPerformerUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkPerformerUpdate', '
  mutation bulkPerformerUpdate($input: BulkPerformerUpdateInput!) { bulkPerformerUpdate(input: $input) { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkPerformerUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: performerMerge
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
performerMerge <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('performerMerge', '
  mutation performerMerge($input: PerformerMergeInput!) { performerMerge(input: $input) { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$performerMerge, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: studioCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
studioCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('studioCreate', '
  mutation studioCreate($input: StudioCreateInput!) { studioCreate(input: $input) { ...Studio } }
  fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$studioCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: studioUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
studioUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('studioUpdate', '
  mutation studioUpdate($input: StudioUpdateInput!) { studioUpdate(input: $input) { ...Studio } }
  fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$studioUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: studioDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
studioDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('studioDestroy', '
  mutation studioDestroy($input: StudioDestroyInput!) { studioDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$studioDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: studiosDestroy
#' 
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
studiosDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('studiosDestroy', '
  mutation studiosDestroy($ids: [ID!]!) { studiosDestroy(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$studiosDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkStudioUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkStudioUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkStudioUpdate', '
  mutation bulkStudioUpdate($input: BulkStudioUpdateInput!) { bulkStudioUpdate(input: $input) { ...Studio } }
  fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkStudioUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: groupCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
groupCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('groupCreate', '
  mutation groupCreate($input: GroupCreateInput!) { groupCreate(input: $input) { ...Group } }
  fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  fragment GroupDescription on GroupDescription { group { id name } description }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$groupCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: groupUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
groupUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('groupUpdate', '
  mutation groupUpdate($input: GroupUpdateInput!) { groupUpdate(input: $input) { ...Group } }
  fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  fragment GroupDescription on GroupDescription { group { id name } description }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$groupUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: groupDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
groupDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('groupDestroy', '
  mutation groupDestroy($input: GroupDestroyInput!) { groupDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$groupDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: groupsDestroy
#' 
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
groupsDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('groupsDestroy', '
  mutation groupsDestroy($ids: [ID!]!) { groupsDestroy(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$groupsDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkGroupUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkGroupUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkGroupUpdate', '
  mutation bulkGroupUpdate($input: BulkGroupUpdateInput!) { bulkGroupUpdate(input: $input) { ...Group } }
  fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  fragment GroupDescription on GroupDescription { group { id name } description }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkGroupUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: addGroupSubGroups
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
addGroupSubGroups <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('addGroupSubGroups', '
  mutation addGroupSubGroups($input: GroupSubGroupAddInput!) { addGroupSubGroups(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$addGroupSubGroups, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: removeGroupSubGroups
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
removeGroupSubGroups <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('removeGroupSubGroups', '
  mutation removeGroupSubGroups($input: GroupSubGroupRemoveInput!) { removeGroupSubGroups(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$removeGroupSubGroups, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: reorderSubGroups
#' @description Reorder sub groups within a group. Returns true if successful.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
reorderSubGroups <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('reorderSubGroups', '
  mutation reorderSubGroups($input: ReorderSubGroupsInput!) { reorderSubGroups(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$reorderSubGroups, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: tagCreate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
tagCreate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagCreate', '
  mutation tagCreate($input: TagCreateInput!) { tagCreate(input: $input) { ...Tag } }
  fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$tagCreate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: tagUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
tagUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagUpdate', '
  mutation tagUpdate($input: TagUpdateInput!) { tagUpdate(input: $input) { ...Tag } }
  fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$tagUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: tagDestroy
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
tagDestroy <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagDestroy', '
  mutation tagDestroy($input: TagDestroyInput!) { tagDestroy(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$tagDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: tagsDestroy
#' 
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
tagsDestroy <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('tagsDestroy', '
  mutation tagsDestroy($ids: [ID!]!) { tagsDestroy(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$tagsDestroy, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: tagsMerge
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
tagsMerge <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('tagsMerge', '
  mutation tagsMerge($input: TagsMergeInput!) { tagsMerge(input: $input) { ...Tag } }
  fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$tagsMerge, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: bulkTagUpdate
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
bulkTagUpdate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('bulkTagUpdate', '
  mutation bulkTagUpdate($input: BulkTagUpdateInput!) { bulkTagUpdate(input: $input) { ...Tag } }
  fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$bulkTagUpdate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: moveFiles
#' @description Moves the given files to the given destination. Returns true if successful.
#' Either the destination_folder or destination_folder_id must be provided.
#' If both are provided, the destination_folder_id takes precedence.
#' Destination folder must be a subfolder of one of the stash library paths.
#' If provided, destination_basename must be a valid filename with an extension that
#' matches one of the media extensions.
#' Creates folder hierarchy if needed.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
moveFiles <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('moveFiles', '
  mutation moveFiles($input: MoveFilesInput!) { moveFiles(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$moveFiles, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: deleteFiles
#' 
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
deleteFiles <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('deleteFiles', '
  mutation deleteFiles($ids: [ID!]!) { deleteFiles(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$deleteFiles, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: destroyFiles
#' @description Deletes file entries from the database without deleting the files from the filesystem
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
destroyFiles <- function(ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('destroyFiles', '
  mutation destroyFiles($ids: [ID!]!) { destroyFiles(ids: $ids) }
  
  ')

  variables <- list()
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$destroyFiles, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: fileSetFingerprints
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
fileSetFingerprints <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('fileSetFingerprints', '
  mutation fileSetFingerprints($input: FileSetFingerprintsInput!) { fileSetFingerprints(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$fileSetFingerprints, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: revealFileInFileManager
#' @description Reveal the file in the system file manager
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
revealFileInFileManager <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('revealFileInFileManager', '
  mutation revealFileInFileManager($id: ID!) { revealFileInFileManager(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$revealFileInFileManager, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: revealFolderInFileManager
#' @description Reveal the folder in the system file manager
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
revealFolderInFileManager <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('revealFolderInFileManager', '
  mutation revealFolderInFileManager($id: ID!) { revealFolderInFileManager(id: $id) }
  
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$revealFolderInFileManager, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: saveFilter
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
saveFilter <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('saveFilter', '
  mutation saveFilter($input: SaveFilterInput!) { saveFilter(input: $input) { ...SavedFilter } }
  fragment SavedFilter on SavedFilter { id mode name find_filter { ...SavedFindFilterType } object_filter ui_options }
  fragment SavedFindFilterType on SavedFindFilterType { q page per_page sort direction }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$saveFilter, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: destroySavedFilter
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
destroySavedFilter <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('destroySavedFilter', '
  mutation destroySavedFilter($input: DestroyFilterInput!) { destroySavedFilter(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$destroySavedFilter, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureGeneral
#' @description Change general configuration options
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureGeneral <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureGeneral', '
  mutation configureGeneral($input: ConfigGeneralInput!) { configureGeneral(input: $input) { ...ConfigGeneralResult } }
  fragment ConfigGeneralResult on ConfigGeneralResult { stashes { ...StashConfig } databasePath backupDirectoryPath deleteTrashPath generatedPath metadataPath configFilePath scrapersPath pluginsPath cachePath blobsPath blobsStorage ffmpegPath ffprobePath calculateMD5 videoFileNamingAlgorithm parallelTasks previewAudio previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset transcodeHardwareAcceleration maxTranscodeSize maxStreamingTranscodeSize transcodeInputArgs transcodeOutputArgs liveTranscodeInputArgs liveTranscodeOutputArgs drawFunscriptHeatmapRange writeImageThumbnails createImageClipsFromVideos apiKey username password maxSessionAge logFile logOut logLevel logAccess logFileMaxSize useCustomSpriteInterval spriteInterval minimumSprites maximumSprites spriteScreenshotSize videoExtensions imageExtensions galleryExtensions createGalleriesFromFolders galleryCoverRegex excludes imageExcludes customPerformerImageLocation stashBoxes { ...StashBox } pythonPath scraperPackageSources { ...PackageSource } pluginPackageSources { ...PackageSource } }
  fragment StashConfig on StashConfig { path excludeVideo excludeImage }
  fragment StashBox on StashBox { endpoint api_key name max_requests_per_minute }
  fragment PackageSource on PackageSource { name url local_path }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureGeneral, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureInterface
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureInterface <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureInterface', '
  mutation configureInterface($input: ConfigInterfaceInput!) { configureInterface(input: $input) { ...ConfigInterfaceResult } }
  fragment ConfigInterfaceResult on ConfigInterfaceResult { sfwContentMode menuItems soundOnPreview wallShowTitle wallPlayback showScrubber maximumLoopDuration noBrowser notificationsEnabled autostartVideo autostartVideoOnPlaySelected continuePlaylistDefault showStudioAsText css cssEnabled javascript javascriptEnabled customLocales customLocalesEnabled disableCustomizations language imageLightbox { ...ConfigImageLightboxResult } disableDropdownCreate { ...ConfigDisableDropdownCreate } handyKey funscriptOffset useStashHostedFunscript }
  fragment ConfigImageLightboxResult on ConfigImageLightboxResult { slideshowDelay displayMode scaleUp resetZoomOnNav scrollMode scrollAttemptsBeforeChange disableAnimation }
  fragment ConfigDisableDropdownCreate on ConfigDisableDropdownCreate { performer tag studio movie gallery }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureInterface, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureDLNA
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureDLNA <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureDLNA', '
  mutation configureDLNA($input: ConfigDLNAInput!) { configureDLNA(input: $input) { ...ConfigDLNAResult } }
  fragment ConfigDLNAResult on ConfigDLNAResult { serverName enabled port whitelistedIPs interfaces videoSortOrder }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureDLNA, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureScraping
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureScraping <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureScraping', '
  mutation configureScraping($input: ConfigScrapingInput!) { configureScraping(input: $input) { ...ConfigScrapingResult } }
  fragment ConfigScrapingResult on ConfigScrapingResult { scraperUserAgent scraperCDPPath scraperCertCheck excludeTagPatterns }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureScraping, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureDefaults
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureDefaults <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureDefaults', '
  mutation configureDefaults($input: ConfigDefaultSettingsInput!) { configureDefaults(input: $input) { ...ConfigDefaultSettingsResult } }
  fragment ConfigDefaultSettingsResult on ConfigDefaultSettingsResult { scan { ...ScanMetadataOptions } identify { ...IdentifyMetadataTaskOptions } autoTag { ...AutoTagMetadataOptions } generate { ...GenerateMetadataOptions } deleteFile deleteGenerated }
  fragment ScanMetadataOptions on ScanMetadataOptions { rescan scanGenerateCovers scanGeneratePreviews scanGenerateImagePreviews scanGenerateSprites scanGeneratePhashes scanGenerateImagePhashes scanGenerateThumbnails scanGenerateClipPreviews }
  fragment IdentifyMetadataTaskOptions on IdentifyMetadataTaskOptions { sources { ...IdentifySource } options { ...IdentifyMetadataOptions } }
  fragment AutoTagMetadataOptions on AutoTagMetadataOptions { performers studios tags }
  fragment GenerateMetadataOptions on GenerateMetadataOptions { covers sprites previews imagePreviews previewOptions { ...GeneratePreviewOptions } markers markerImagePreviews markerScreenshots transcodes phashes interactiveHeatmapsSpeeds imageThumbnails clipPreviews }
  fragment IdentifySource on IdentifySource { source { ...ScraperSource } options { ...IdentifyMetadataOptions } }
  fragment IdentifyMetadataOptions on IdentifyMetadataOptions { fieldOptions { ...IdentifyFieldOptions } setCoverImage setOrganized performerGenders skipMultipleMatches skipMultipleMatchTag skipSingleNamePerformers skipSingleNamePerformerTag }
  fragment ScraperSource on ScraperSource { stash_box_endpoint scraper_id }
  fragment IdentifyFieldOptions on IdentifyFieldOptions { field strategy createMissing }
  fragment GeneratePreviewOptions on GeneratePreviewOptions { previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureDefaults, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configurePlugin
#' @description overwrites the entire plugin configuration for the given plugin
#' @param pluginid   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configurePlugin <- function(pluginid = list(), input = list(), ...) {

  query <- ghql::Query$new()
  query$query('configurePlugin', '
  mutation configurePlugin($pluginid: ID! $input: Map!) { configurePlugin(plugin_id: $pluginid input: $input) }
  
  ')

  variables <- list()
  variables[['pluginid']] <- pluginid
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configurePlugin, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureUI
#' @description overwrites the UI configuration
#' if input is provided, then the entire UI configuration is replaced
#' if partial is provided, then the partial UI configuration is merged into the existing UI configuration
#' @param input   See the Playground for further details.
#' @param partial   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureUI <- function(input = NA, partial = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureUI', '
  mutation configureUI($input: Map $partial: Map) { configureUI(input: $input partial: $partial) }
  
  ')

  variables <- list()
  variables[['input']] <- input
  variables[['partial']] <- partial

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureUI, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configureUISetting
#' @description sets a single UI key value
#' key is a dot separated path to the value
#' @param key   See the Playground for further details.
#' @param value   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configureUISetting <- function(key = list(), value = NA, ...) {

  query <- ghql::Query$new()
  query$query('configureUISetting', '
  mutation configureUISetting($key: String! $value: Any) { configureUISetting(key: $key value: $value) }
  
  ')

  variables <- list()
  variables[['key']] <- key
  variables[['value']] <- value

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configureUISetting, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: generateAPIKey
#' @description Generate and set (or clear) API key
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
generateAPIKey <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('generateAPIKey', '
  mutation generateAPIKey($input: GenerateAPIKeyInput!) { generateAPIKey(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$generateAPIKey, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: exportObjects
#' @description Returns a link to download the result
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
exportObjects <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('exportObjects', '
  mutation exportObjects($input: ExportObjectsInput!) { exportObjects(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$exportObjects, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: importObjects
#' @description Performs an incremental import. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
importObjects <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('importObjects', '
  mutation importObjects($input: ImportObjectsInput!) { importObjects(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$importObjects, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataImport
#' @description Start an full import. Completely wipes the database and imports from the metadata directory. Returns the job ID
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataImport <- function(...) {

  query <- ghql::Query$new()
  query$query('metadataImport', '
  mutation metadataImport { metadataImport }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataImport, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataExport
#' @description Start a full export. Outputs to the metadata directory. Returns the job ID
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataExport <- function(...) {

  query <- ghql::Query$new()
  query$query('metadataExport', '
  mutation metadataExport { metadataExport }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataExport, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataScan
#' @description Start a scan. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataScan <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataScan', '
  mutation metadataScan($input: ScanMetadataInput!) { metadataScan(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataScan, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataGenerate
#' @description Start generating content. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataGenerate <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataGenerate', '
  mutation metadataGenerate($input: GenerateMetadataInput!) { metadataGenerate(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataGenerate, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataAutoTag
#' @description Start auto-tagging. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataAutoTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataAutoTag', '
  mutation metadataAutoTag($input: AutoTagMetadataInput!) { metadataAutoTag(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataAutoTag, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataClean
#' @description Clean metadata. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataClean <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataClean', '
  mutation metadataClean($input: CleanMetadataInput!) { metadataClean(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataClean, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataCleanGenerated
#' @description Clean generated files. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataCleanGenerated <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataCleanGenerated', '
  mutation metadataCleanGenerated($input: CleanGeneratedInput!) { metadataCleanGenerated(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataCleanGenerated, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: metadataIdentify
#' @description Identifies scenes using scrapers. Returns the job ID
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
metadataIdentify <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('metadataIdentify', '
  mutation metadataIdentify($input: IdentifyMetadataInput!) { metadataIdentify(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$metadataIdentify, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: migrateHashNaming
#' @description Migrate generated files for the current hash naming
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
migrateHashNaming <- function(...) {

  query <- ghql::Query$new()
  query$query('migrateHashNaming', '
  mutation migrateHashNaming { migrateHashNaming }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$migrateHashNaming, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: migrateSceneScreenshots
#' @description Migrates legacy scene screenshot files into the blob storage
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
migrateSceneScreenshots <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('migrateSceneScreenshots', '
  mutation migrateSceneScreenshots($input: MigrateSceneScreenshotsInput!) { migrateSceneScreenshots(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$migrateSceneScreenshots, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: migrateBlobs
#' @description Migrates blobs from the old storage system to the current one
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
migrateBlobs <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('migrateBlobs', '
  mutation migrateBlobs($input: MigrateBlobsInput!) { migrateBlobs(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$migrateBlobs, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: anonymiseDatabase
#' @description Anonymise the database in a separate file. Optionally returns a link to download the database file
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
anonymiseDatabase <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('anonymiseDatabase', '
  mutation anonymiseDatabase($input: AnonymiseDatabaseInput!) { anonymiseDatabase(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$anonymiseDatabase, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: optimiseDatabase
#' @description Optimises the database. Returns the job ID
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
optimiseDatabase <- function(...) {

  query <- ghql::Query$new()
  query$query('optimiseDatabase', '
  mutation optimiseDatabase { optimiseDatabase }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$optimiseDatabase, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: reloadScrapers
#' @description Reload scrapers
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
reloadScrapers <- function(...) {

  query <- ghql::Query$new()
  query$query('reloadScrapers', '
  mutation reloadScrapers { reloadScrapers }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$reloadScrapers, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: setPluginsEnabled
#' @description Enable/disable plugins - enabledMap is a map of plugin IDs to enabled booleans.
#' Plugins not in the map are not affected.
#' @param enabledMap   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
setPluginsEnabled <- function(enabledMap = list(), ...) {

  query <- ghql::Query$new()
  query$query('setPluginsEnabled', '
  mutation setPluginsEnabled($enabledMap: BoolMap!) { setPluginsEnabled(enabledMap: $enabledMap) }
  
  ')

  variables <- list()
  variables[['enabledMap']] <- enabledMap

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$setPluginsEnabled, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: runPluginTask
#' @description Run a plugin task.
#' If task_name is provided, then the task must exist in the plugin config and the tasks configuration
#' will be used to run the plugin.
#' If no task_name is provided, then the plugin will be executed with the arguments provided only.
#' Returns the job ID
#' @param pluginid   See the Playground for further details.
#' @param taskname   if provided, then the default args will be applied
#' @param description   displayed in the task queue
#' @param args   See the Playground for further details.
#' @param argsmap   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
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

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$runPluginTask, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: runPluginOperation
#' @description Runs a plugin operation. The operation is run immediately and does not use the job queue.
#' Returns a map of the result.
#' @param pluginid   See the Playground for further details.
#' @param args   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
runPluginOperation <- function(pluginid = list(), args = NA, ...) {

  query <- ghql::Query$new()
  query$query('runPluginOperation', '
  mutation runPluginOperation($pluginid: ID! $args: Map) { runPluginOperation(plugin_id: $pluginid args: $args) }
  
  ')

  variables <- list()
  variables[['pluginid']] <- pluginid
  variables[['args']] <- args

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$runPluginOperation, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: reloadPlugins
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
reloadPlugins <- function(...) {

  query <- ghql::Query$new()
  query$query('reloadPlugins', '
  mutation reloadPlugins { reloadPlugins }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$reloadPlugins, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: installPackages
#' @description Installs the given packages.
#' If a package is already installed, it will be updated if needed..
#' If an error occurs when installing a package, the job will continue to install the remaining packages.
#' Returns the job ID
#' @param type   See the Playground for further details.
#' @param packages   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
installPackages <- function(type = NA, packages = NA, ...) {

  query <- ghql::Query$new()
  query$query('installPackages', '
  mutation installPackages($type: PackageType! $packages: [PackageSpecInput!]!) { installPackages(type: $type packages: $packages) }
  
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['packages']] <- packages

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$installPackages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: updatePackages
#' @description Updates the given packages.
#' If a package is not installed, it will not be installed.
#' If a package does not need to be updated, it will not be updated.
#' If no packages are provided, all packages of the given type will be updated.
#' If an error occurs when updating a package, the job will continue to update the remaining packages.
#' Returns the job ID.
#' @param type   See the Playground for further details.
#' @param packages   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
updatePackages <- function(type = NA, packages = NA, ...) {

  query <- ghql::Query$new()
  query$query('updatePackages', '
  mutation updatePackages($type: PackageType! $packages: [PackageSpecInput!]) { updatePackages(type: $type packages: $packages) }
  
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['packages']] <- packages

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$updatePackages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: uninstallPackages
#' @description Uninstalls the given packages.
#' If an error occurs when uninstalling a package, the job will continue to uninstall the remaining packages.
#' Returns the job ID
#' @param type   See the Playground for further details.
#' @param packages   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
uninstallPackages <- function(type = NA, packages = NA, ...) {

  query <- ghql::Query$new()
  query$query('uninstallPackages', '
  mutation uninstallPackages($type: PackageType! $packages: [PackageSpecInput!]!) { uninstallPackages(type: $type packages: $packages) }
  
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['packages']] <- packages

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$uninstallPackages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: stopJob
#' 
#' @param jobid   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
stopJob <- function(jobid = list(), ...) {

  query <- ghql::Query$new()
  query$query('stopJob', '
  mutation stopJob($jobid: ID!) { stopJob(job_id: $jobid) }
  
  ')

  variables <- list()
  variables[['jobid']] <- jobid

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$stopJob, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: stopAllJobs
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
stopAllJobs <- function(...) {

  query <- ghql::Query$new()
  query$query('stopAllJobs', '
  mutation stopAllJobs { stopAllJobs }
  
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$stopAllJobs, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: submitStashBoxFingerprints
#' @description Submit fingerprints to stash-box instance
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
submitStashBoxFingerprints <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('submitStashBoxFingerprints', '
  mutation submitStashBoxFingerprints($input: StashBoxFingerprintSubmissionInput!) { submitStashBoxFingerprints(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$submitStashBoxFingerprints, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: submitStashBoxSceneDraft
#' @description Submit scene as draft to stash-box instance
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
submitStashBoxSceneDraft <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('submitStashBoxSceneDraft', '
  mutation submitStashBoxSceneDraft($input: StashBoxDraftSubmissionInput!) { submitStashBoxSceneDraft(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$submitStashBoxSceneDraft, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: submitStashBoxPerformerDraft
#' @description Submit performer as draft to stash-box instance
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
submitStashBoxPerformerDraft <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('submitStashBoxPerformerDraft', '
  mutation submitStashBoxPerformerDraft($input: StashBoxDraftSubmissionInput!) { submitStashBoxPerformerDraft(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$submitStashBoxPerformerDraft, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: backupDatabase
#' @description Backup the database. Optionally returns a link to download the database file
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
backupDatabase <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('backupDatabase', '
  mutation backupDatabase($input: BackupDatabaseInput!) { backupDatabase(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$backupDatabase, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: querySQL
#' @description DANGEROUS: Execute an arbitrary SQL statement that returns rows.
#' @param sql   See the Playground for further details.
#' @param args   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
querySQL <- function(sql = list(), args = NA, ...) {

  query <- ghql::Query$new()
  query$query('querySQL', '
  mutation querySQL($sql: String! $args: [Any]) { querySQL(sql: $sql args: $args) { ...SQLQueryResult } }
  fragment SQLQueryResult on SQLQueryResult { columns rows }
  ')

  variables <- list()
  variables[['sql']] <- sql
  variables[['args']] <- args

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$querySQL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: execSQL
#' @description DANGEROUS: Execute an arbitrary SQL statement without returning any rows.
#' @param sql   See the Playground for further details.
#' @param args   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
execSQL <- function(sql = list(), args = NA, ...) {

  query <- ghql::Query$new()
  query$query('execSQL', '
  mutation execSQL($sql: String! $args: [Any]) { execSQL(sql: $sql args: $args) { ...SQLExecResult } }
  fragment SQLExecResult on SQLExecResult { rows_affected last_insert_id }
  ')

  variables <- list()
  variables[['sql']] <- sql
  variables[['args']] <- args

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$execSQL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: stashBoxBatchPerformerTag
#' @description Run batch performer tag task. Returns the job ID.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
stashBoxBatchPerformerTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('stashBoxBatchPerformerTag', '
  mutation stashBoxBatchPerformerTag($input: StashBoxBatchTagInput!) { stashBoxBatchPerformerTag(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$stashBoxBatchPerformerTag, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: stashBoxBatchStudioTag
#' @description Run batch studio tag task. Returns the job ID.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
stashBoxBatchStudioTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('stashBoxBatchStudioTag', '
  mutation stashBoxBatchStudioTag($input: StashBoxBatchTagInput!) { stashBoxBatchStudioTag(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$stashBoxBatchStudioTag, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: stashBoxBatchTagTag
#' @description Run batch tag tag task. Returns the job ID.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
stashBoxBatchTagTag <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('stashBoxBatchTagTag', '
  mutation stashBoxBatchTagTag($input: StashBoxBatchTagInput!) { stashBoxBatchTagTag(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$stashBoxBatchTagTag, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: enableDLNA
#' @description Enables DLNA for an optional duration. Has no effect if DLNA is enabled by default
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
enableDLNA <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('enableDLNA', '
  mutation enableDLNA($input: EnableDLNAInput!) { enableDLNA(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$enableDLNA, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: disableDLNA
#' @description Disables DLNA for an optional duration. Has no effect if DLNA is disabled by default
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
disableDLNA <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('disableDLNA', '
  mutation disableDLNA($input: DisableDLNAInput!) { disableDLNA(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$disableDLNA, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: addTempDLNAIP
#' @description Enables an IP address for DLNA for an optional duration
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
addTempDLNAIP <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('addTempDLNAIP', '
  mutation addTempDLNAIP($input: AddTempDLNAIPInput!) { addTempDLNAIP(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$addTempDLNAIP, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: removeTempDLNAIP
#' @description Removes an IP address from the temporary DLNA whitelist
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
removeTempDLNAIP <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('removeTempDLNAIP', '
  mutation removeTempDLNAIP($input: RemoveTempDLNAIPInput!) { removeTempDLNAIP(input: $input) }
  
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$removeTempDLNAIP, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findSavedFilter
#' 
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findSavedFilter <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findSavedFilter', '
  query findSavedFilter($id: ID!) { findSavedFilter(id: $id) { ...SavedFilter } }
  fragment SavedFilter on SavedFilter { id mode name find_filter { ...SavedFindFilterType } object_filter ui_options }
  fragment SavedFindFilterType on SavedFindFilterType { q page per_page sort direction }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findSavedFilter, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findSavedFilters
#' 
#' @param mode   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findSavedFilters <- function(mode = NA, ...) {

  query <- ghql::Query$new()
  query$query('findSavedFilters', '
  query findSavedFilters($mode: FilterMode) { findSavedFilters(mode: $mode) { ...SavedFilter } }
  fragment SavedFilter on SavedFilter { id mode name find_filter { ...SavedFindFilterType } object_filter ui_options }
  fragment SavedFindFilterType on SavedFindFilterType { q page per_page sort direction }
  ')

  variables <- list()
  variables[['mode']] <- mode

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findSavedFilters, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findFile
#' @description Find a file by its id or path
#' @param id   See the Playground for further details.
#' @param path   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findFile <- function(id = NA, path = NA, ...) {

  query <- ghql::Query$new()
  query$query('findFile', '
  query findFile($id: ID $path: String) { findFile(id: $id path: $path) }
  
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['path']] <- path

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findFile, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findFiles
#' @description Queries for Files
#' @param filefilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findFiles <- function(filefilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findFiles', '
  query findFiles($filefilter: FileFilterType $filter: FindFilterType $ids: [ID!]) { findFiles(file_filter: $filefilter filter: $filter ids: $ids) { ...FindFilesResultType } }
  fragment FindFilesResultType on FindFilesResultType { count megapixels duration size files }
  ')

  variables <- list()
  variables[['filefilter']] <- filefilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findFiles, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findFolder
#' @description Find a file by its id or path
#' @param id   See the Playground for further details.
#' @param path   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
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
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findFolder, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findFolders
#' @description Queries for Files
#' @param folderfilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findFolders <- function(folderfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findFolders', '
  query findFolders($folderfilter: FolderFilterType $filter: FindFilterType $ids: [ID!]) { findFolders(folder_filter: $folderfilter filter: $filter ids: $ids) { ...FindFoldersResultType } }
  fragment FindFoldersResultType on FindFoldersResultType { count folders { ...Folder } }
  fragment Folder on Folder { id path basename parent_folder { id path basename } parent_folders { id path basename } zip_file { id path basename } sub_folders { id path basename } mod_time created_at updated_at }
  ')

  variables <- list()
  variables[['folderfilter']] <- folderfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "folders"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findFolders, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findScene
#' @description Find a scene by ID or Checksum
#' @param id   See the Playground for further details.
#' @param checksum   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findScene <- function(id = NA, checksum = NA, ...) {

  query <- ghql::Query$new()
  query$query('findScene', '
  query findScene($id: ID $checksum: String) { findScene(id: $id checksum: $checksum) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['checksum']] <- checksum

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findScene, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findSceneByHash
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findSceneByHash <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('findSceneByHash', '
  query findSceneByHash($input: SceneHashInput!) { findSceneByHash(input: $input) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findSceneByHash, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findScenes
#' @description A function which queries Scene objects
#' @param scenefilter   See the Playground for further details.
#' @param sceneids   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findScenes <- function(scenefilter = NA, sceneids = list(), ids = list(), filter = NA, ...) {

  query <- ghql::Query$new()
  query$query('findScenes', '
  query findScenes($scenefilter: SceneFilterType $sceneids: [Int!] $ids: [ID!] $filter: FindFilterType) { findScenes(scene_filter: $scenefilter scene_ids: $sceneids ids: $ids filter: $filter) { ...FindScenesResultType } }
  fragment FindScenesResultType on FindScenesResultType { count duration filesize scenes { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['scenefilter']] <- scenefilter
  variables[['sceneids']] <- sceneids
  variables[['ids']] <- ids
  variables[['filter']] <- filter

  return_default <- "scenes"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findScenes, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findScenesByPathRegex
#' 
#' @param filter   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findScenesByPathRegex <- function(filter = NA, ...) {

  query <- ghql::Query$new()
  query$query('findScenesByPathRegex', '
  query findScenesByPathRegex($filter: FindFilterType) { findScenesByPathRegex(filter: $filter) { ...FindScenesResultType } }
  fragment FindScenesResultType on FindScenesResultType { count duration filesize scenes { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['filter']] <- filter

  return_default <- "scenes"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findScenesByPathRegex, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findDuplicateScenes
#' @description Returns any groups of scenes that are perceptual duplicates within the queried distance
#' and the difference between their duration is smaller than durationDiff
#' @param distance   See the Playground for further details.
#' @param durationdiff   Max difference in seconds between files in order to be considered for similarity matching.
#' Fractional seconds are ok: 0.5 will mean only files that have durations within 0.5 seconds between them will be matched based on PHash distance.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findDuplicateScenes <- function(distance = NA, durationdiff = NA, ...) {

  query <- ghql::Query$new()
  query$query('findDuplicateScenes', '
  query findDuplicateScenes($distance: Int $durationdiff: Float) { findDuplicateScenes(distance: $distance duration_diff: $durationdiff) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['distance']] <- distance
  variables[['durationdiff']] <- durationdiff

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findDuplicateScenes, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneStreams
#' @description Return valid stream paths
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneStreams <- function(id = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneStreams', '
  query sceneStreams($id: ID) { sceneStreams(id: $id) { ...SceneStreamEndpoint } }
  fragment SceneStreamEndpoint on SceneStreamEndpoint { url mime_type label }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneStreams, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: parseSceneFilenames
#' 
#' @param filter   See the Playground for further details.
#' @param config   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
parseSceneFilenames <- function(filter = NA, config = NA, ...) {

  query <- ghql::Query$new()
  query$query('parseSceneFilenames', '
  query parseSceneFilenames($filter: FindFilterType $config: SceneParserInput!) { parseSceneFilenames(filter: $filter config: $config) { ...SceneParserResultType } }
  fragment SceneParserResultType on SceneParserResultType { count results { ...SceneParserResult } }
  fragment SceneParserResult on SceneParserResult { scene { id title } title code details director url date rating100 studio_id gallery_ids performer_ids movies { ...SceneMovieID } tag_ids }
  fragment SceneMovieID on SceneMovieID { movie_id scene_index }
  ')

  variables <- list()
  variables[['filter']] <- filter
  variables[['config']] <- config

  return_default <- "results"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$parseSceneFilenames, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findSceneMarkers
#' @description A function which queries SceneMarker objects
#' @param scenemarkerfilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findSceneMarkers <- function(scenemarkerfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findSceneMarkers', '
  query findSceneMarkers($scenemarkerfilter: SceneMarkerFilterType $filter: FindFilterType $ids: [ID!]) { findSceneMarkers(scene_marker_filter: $scenemarkerfilter filter: $filter ids: $ids) { ...FindSceneMarkersResultType } }
  fragment FindSceneMarkersResultType on FindSceneMarkersResultType { count scene_markers { ...SceneMarker } }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['scenemarkerfilter']] <- scenemarkerfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "scene_markers"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findSceneMarkers, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findImage
#' 
#' @param id   See the Playground for further details.
#' @param checksum   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findImage <- function(id = NA, checksum = NA, ...) {

  query <- ghql::Query$new()
  query$query('findImage', '
  query findImage($id: ID $checksum: String) { findImage(id: $id checksum: $checksum) { ...Image } }
  fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
  fragment ImagePathsType on ImagePathsType { thumbnail preview }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['id']] <- id
  variables[['checksum']] <- checksum

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findImage, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findImages
#' @description A function which queries Scene objects
#' @param imagefilter   See the Playground for further details.
#' @param imageids   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findImages <- function(imagefilter = NA, imageids = list(), ids = list(), filter = NA, ...) {

  query <- ghql::Query$new()
  query$query('findImages', '
  query findImages($imagefilter: ImageFilterType $imageids: [Int!] $ids: [ID!] $filter: FindFilterType) { findImages(image_filter: $imagefilter image_ids: $imageids ids: $ids filter: $filter) { ...FindImagesResultType } }
  fragment FindImagesResultType on FindImagesResultType { count megapixels filesize images { ...Image } }
  fragment Image on Image { id title code rating100 urls date details photographer o_counter organized created_at updated_at visual_files { ...VisualFile } paths { ...ImagePathsType } galleries { id title } studio { id name } tags { id name } performers { id name gender } custom_fields }
  fragment VisualFile on VisualFile { ...VideoFile ...ImageFile }
  fragment ImagePathsType on ImagePathsType { thumbnail preview }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ImageFile on ImageFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height created_at updated_at }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['imagefilter']] <- imagefilter
  variables[['imageids']] <- imageids
  variables[['ids']] <- ids
  variables[['filter']] <- filter

  return_default <- "images"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findImages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findPerformer
#' @description Find a performer by ID
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findPerformer <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findPerformer', '
  query findPerformer($id: ID!) { findPerformer(id: $id) { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findPerformer, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findPerformers
#' @description A function which queries Performer objects
#' @param performerfilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param performerids   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findPerformers <- function(performerfilter = NA, filter = NA, performerids = list(), ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findPerformers', '
  query findPerformers($performerfilter: PerformerFilterType $filter: FindFilterType $performerids: [Int!] $ids: [ID!]) { findPerformers(performer_filter: $performerfilter filter: $filter performer_ids: $performerids ids: $ids) { ...FindPerformersResultType } }
  fragment FindPerformersResultType on FindPerformersResultType { count performers { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()
  variables[['performerfilter']] <- performerfilter
  variables[['filter']] <- filter
  variables[['performerids']] <- performerids
  variables[['ids']] <- ids

  return_default <- "performers"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findPerformers, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findStudio
#' @description Find a studio by ID
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findStudio <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findStudio', '
  query findStudio($id: ID!) { findStudio(id: $id) { ...Studio } }
  fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findStudio, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findStudios
#' @description A function which queries Studio objects
#' @param studiofilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findStudios <- function(studiofilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findStudios', '
  query findStudios($studiofilter: StudioFilterType $filter: FindFilterType $ids: [ID!]) { findStudios(studio_filter: $studiofilter filter: $filter ids: $ids) { ...FindStudiosResultType } }
  fragment FindStudiosResultType on FindStudiosResultType { count studios { ...Studio } }
  fragment Studio on Studio { id name urls parent_studio { id name } child_studios { id name } aliases tags { id name } ignore_auto_tag organized image_path scene_count image_count gallery_count performer_count group_count stash_ids { endpoint stash_id } rating100 favorite details created_at updated_at groups { id name } o_counter custom_fields }
  ')

  variables <- list()
  variables[['studiofilter']] <- studiofilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "studios"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findStudios, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findGroup
#' @description Find a group by ID
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findGroup <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGroup', '
  query findGroup($id: ID!) { findGroup(id: $id) { ...Group } }
  fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  fragment GroupDescription on GroupDescription { group { id name } description }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findGroup, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findGroups
#' @description A function which queries Group objects
#' @param groupfilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findGroups <- function(groupfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGroups', '
  query findGroups($groupfilter: GroupFilterType $filter: FindFilterType $ids: [ID!]) { findGroups(group_filter: $groupfilter filter: $filter ids: $ids) { ...FindGroupsResultType } }
  fragment FindGroupsResultType on FindGroupsResultType { count groups { ...Group } }
  fragment Group on Group { id name aliases duration date rating100 studio { id name } director synopsis urls tags { id name } created_at updated_at containing_groups { ...GroupDescription } sub_groups { ...GroupDescription } front_image_path back_image_path scene_count performer_count sub_group_count scenes { id title } o_counter custom_fields }
  fragment GroupDescription on GroupDescription { group { id name } description }
  ')

  variables <- list()
  variables[['groupfilter']] <- groupfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "groups"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findGroups, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findGallery
#' 
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findGallery <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGallery', '
  query findGallery($id: ID!) { findGallery(id: $id) { ...Gallery } }
  fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  fragment GalleryPathsType on GalleryPathsType { cover preview }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findGallery, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findGalleries
#' 
#' @param galleryfilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findGalleries <- function(galleryfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findGalleries', '
  query findGalleries($galleryfilter: GalleryFilterType $filter: FindFilterType $ids: [ID!]) { findGalleries(gallery_filter: $galleryfilter filter: $filter ids: $ids) { ...FindGalleriesResultType } }
  fragment FindGalleriesResultType on FindGalleriesResultType { count galleries { ...Gallery } }
  fragment Gallery on Gallery { id title code urls date details photographer rating100 organized created_at updated_at files { ...GalleryFile } folder { id path basename } chapters { ...GalleryChapter } scenes { id title } studio { id name } image_count tags { id name } performers { id name gender } cover { id } paths { ...GalleryPathsType } custom_fields }
  fragment GalleryFile on GalleryFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } created_at updated_at }
  fragment GalleryChapter on GalleryChapter { id gallery { id title } title image_index created_at updated_at }
  fragment GalleryPathsType on GalleryPathsType { cover preview }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['galleryfilter']] <- galleryfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "galleries"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findGalleries, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findTag
#' 
#' @param id   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findTag <- function(id = list(), ...) {

  query <- ghql::Query$new()
  query$query('findTag', '
  query findTag($id: ID!) { findTag(id: $id) { ...Tag } }
  fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['id']] <- id

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findTag, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findTags
#' 
#' @param tagfilter   See the Playground for further details.
#' @param filter   See the Playground for further details.
#' @param ids   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findTags <- function(tagfilter = NA, filter = NA, ids = list(), ...) {

  query <- ghql::Query$new()
  query$query('findTags', '
  query findTags($tagfilter: TagFilterType $filter: FindFilterType $ids: [ID!]) { findTags(tag_filter: $tagfilter filter: $filter ids: $ids) { ...FindTagsResultType } }
  fragment FindTagsResultType on FindTagsResultType { count tags { ...Tag } }
  fragment Tag on Tag { id name sort_name description aliases ignore_auto_tag created_at updated_at favorite stash_ids { endpoint stash_id } image_path scene_count scene_marker_count image_count gallery_count performer_count studio_count group_count parents { id name } children { id name } parent_count child_count custom_fields }
  ')

  variables <- list()
  variables[['tagfilter']] <- tagfilter
  variables[['filter']] <- filter
  variables[['ids']] <- ids

  return_default <- "tags"
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findTags, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: markerWall
#' @description Retrieve random scene markers for the wall
#' @param q   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
markerWall <- function(q = NA, ...) {

  query <- ghql::Query$new()
  query$query('markerWall', '
  query markerWall($q: String) { markerWall(q: $q) { ...SceneMarker } }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['q']] <- q

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$markerWall, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneWall
#' @description Retrieve random scenes for the wall
#' @param q   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneWall <- function(q = NA, ...) {

  query <- ghql::Query$new()
  query$query('sceneWall', '
  query sceneWall($q: String) { sceneWall(q: $q) { ...Scene } }
  fragment Scene on Scene { id title code details director urls date rating100 organized o_counter interactive interactive_speed captions { ...VideoCaption } created_at updated_at last_played_at resume_time play_duration play_count play_history o_history files { ...VideoFile } paths { ...ScenePathsType } scene_markers { ...SceneMarker } galleries { id title } studio { id name } groups { ...SceneGroup } tags { id name } performers { id name gender } stash_ids { endpoint stash_id } custom_fields }
  fragment VideoCaption on VideoCaption { language_code caption_type }
  fragment VideoFile on VideoFile { id path basename parent_folder { id path basename } zip_file { id path basename } mod_time size fingerprints { ...Fingerprint } format width height duration video_codec audio_codec frame_rate bit_rate created_at updated_at }
  fragment ScenePathsType on ScenePathsType { screenshot preview stream webp vtt sprite funscript interactive_heatmap caption }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  fragment SceneGroup on SceneGroup { group { id name } scene_index }
  fragment Fingerprint on Fingerprint { type value }
  ')

  variables <- list()
  variables[['q']] <- q

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneWall, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: markerStrings
#' @description Get marker strings
#' @param q   See the Playground for further details.
#' @param sort   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
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
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$markerStrings, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: stats
#' @description Get stats
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
stats <- function(...) {

  query <- ghql::Query$new()
  query$query('stats', '
  query stats { stats { ...StatsResultType } }
  fragment StatsResultType on StatsResultType { scene_count scenes_size scenes_duration image_count images_size gallery_count performer_count studio_count group_count tag_count total_o_count total_play_duration total_play_count scenes_played }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$stats, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: sceneMarkerTags
#' @description Organize scene markers by tag for a given scene ID
#' @param sceneid   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
sceneMarkerTags <- function(sceneid = list(), ...) {

  query <- ghql::Query$new()
  query$query('sceneMarkerTags', '
  query sceneMarkerTags($sceneid: ID!) { sceneMarkerTags(scene_id: $sceneid) { ...SceneMarkerTag } }
  fragment SceneMarkerTag on SceneMarkerTag { tag { id name } scene_markers { ...SceneMarker } }
  fragment SceneMarker on SceneMarker { id scene { id title } title seconds end_seconds primary_tag { id name } tags { id name } created_at updated_at stream preview screenshot }
  ')

  variables <- list()
  variables[['sceneid']] <- sceneid

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$sceneMarkerTags, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: logs
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
logs <- function(...) {

  query <- ghql::Query$new()
  query$query('logs', '
  query logs { logs { ...LogEntry } }
  fragment LogEntry on LogEntry { time level message }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$logs, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: listScrapers
#' @description List available scrapers
#' @param types   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
listScrapers <- function(types = NA, ...) {

  query <- ghql::Query$new()
  query$query('listScrapers', '
  query listScrapers($types: [ScrapeContentType!]!) { listScrapers(types: $types) { ...Scraper } }
  fragment Scraper on Scraper { id name performer { ...ScraperSpec } scene { ...ScraperSpec } gallery { ...ScraperSpec } group { ...ScraperSpec } }
  fragment ScraperSpec on ScraperSpec { urls supported_scrapes }
  ')

  variables <- list()
  variables[['types']] <- types

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$listScrapers, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSingleScene
#' @description Scrape for a single scene
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSingleScene <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleScene', '
  query scrapeSingleScene($source: ScraperSourceInput! $input: ScrapeSingleSceneInput!) { scrapeSingleScene(source: $source input: $input) { ...ScrapedScene } }
  fragment ScrapedScene on ScrapedScene { ScrapedScene_title: title ScrapedScene_code: code ScrapedScene_details: details ScrapedScene_director: director ScrapedScene_urls: urls ScrapedScene_date: date file { ...SceneFileType } studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } ScrapedScene_remote_site_id: remote_site_id ScrapedScene_duration: duration fingerprints { ...StashBoxFingerprint } }
  fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment ScrapedGroup on ScrapedGroup { ScrapedGroup_stored_id: stored_id ScrapedGroup_name: name ScrapedGroup_aliases: aliases ScrapedGroup_duration: duration ScrapedGroup_date: date ScrapedGroup_rating: rating ScrapedGroup_director: director ScrapedGroup_urls: urls ScrapedGroup_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedGroup_front_image: front_image ScrapedGroup_back_image: back_image }
  fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSingleScene, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeMultiScenes
#' @description Scrape for multiple scenes
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeMultiScenes <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeMultiScenes', '
  query scrapeMultiScenes($source: ScraperSourceInput! $input: ScrapeMultiScenesInput!) { scrapeMultiScenes(source: $source input: $input) { ...ScrapedScene } }
  fragment ScrapedScene on ScrapedScene { ScrapedScene_title: title ScrapedScene_code: code ScrapedScene_details: details ScrapedScene_director: director ScrapedScene_urls: urls ScrapedScene_date: date file { ...SceneFileType } studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } ScrapedScene_remote_site_id: remote_site_id ScrapedScene_duration: duration fingerprints { ...StashBoxFingerprint } }
  fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment ScrapedGroup on ScrapedGroup { ScrapedGroup_stored_id: stored_id ScrapedGroup_name: name ScrapedGroup_aliases: aliases ScrapedGroup_duration: duration ScrapedGroup_date: date ScrapedGroup_rating: rating ScrapedGroup_director: director ScrapedGroup_urls: urls ScrapedGroup_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedGroup_front_image: front_image ScrapedGroup_back_image: back_image }
  fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeMultiScenes, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSingleStudio
#' @description Scrape for a single studio
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSingleStudio <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleStudio', '
  query scrapeSingleStudio($source: ScraperSourceInput! $input: ScrapeSingleStudioInput!) { scrapeSingleStudio(source: $source input: $input) { ...ScrapedStudio } }
  fragment ScrapedStudio on ScrapedStudio { ScrapedStudio_stored_id: stored_id ScrapedStudio_name: name ScrapedStudio_urls: urls parent { stored_id name } ScrapedStudio_details: details ScrapedStudio_aliases: aliases tags { ...ScrapedTag } ScrapedStudio_remote_site_id: remote_site_id }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSingleStudio, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSingleTag
#' @description Scrape for a single tag
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSingleTag <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleTag', '
  query scrapeSingleTag($source: ScraperSourceInput! $input: ScrapeSingleTagInput!) { scrapeSingleTag(source: $source input: $input) { ...ScrapedTag } }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSingleTag, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSinglePerformer
#' @description Scrape for a single performer
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSinglePerformer <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSinglePerformer', '
  query scrapeSinglePerformer($source: ScraperSourceInput! $input: ScrapeSinglePerformerInput!) { scrapeSinglePerformer(source: $source input: $input) { ...ScrapedPerformer } }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSinglePerformer, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeMultiPerformers
#' @description Scrape for multiple performers
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeMultiPerformers <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeMultiPerformers', '
  query scrapeMultiPerformers($source: ScraperSourceInput! $input: ScrapeMultiPerformersInput!) { scrapeMultiPerformers(source: $source input: $input) { ...ScrapedPerformer } }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeMultiPerformers, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSingleGallery
#' @description Scrape for a single gallery
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSingleGallery <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleGallery', '
  query scrapeSingleGallery($source: ScraperSourceInput! $input: ScrapeSingleGalleryInput!) { scrapeSingleGallery(source: $source input: $input) { ...ScrapedGallery } }
  fragment ScrapedGallery on ScrapedGallery { ScrapedGallery_title: title ScrapedGallery_code: code ScrapedGallery_details: details ScrapedGallery_photographer: photographer ScrapedGallery_urls: urls ScrapedGallery_date: date studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSingleGallery, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSingleGroup
#' @description Scrape for a single group
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSingleGroup <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleGroup', '
  query scrapeSingleGroup($source: ScraperSourceInput! $input: ScrapeSingleGroupInput!) { scrapeSingleGroup(source: $source input: $input) { ...ScrapedGroup } }
  fragment ScrapedGroup on ScrapedGroup { ScrapedGroup_stored_id: stored_id ScrapedGroup_name: name ScrapedGroup_aliases: aliases ScrapedGroup_duration: duration ScrapedGroup_date: date ScrapedGroup_rating: rating ScrapedGroup_director: director ScrapedGroup_urls: urls ScrapedGroup_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedGroup_front_image: front_image ScrapedGroup_back_image: back_image }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSingleGroup, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSingleImage
#' @description Scrape for a single image
#' @param source   See the Playground for further details.
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSingleImage <- function(source = NA, input = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeSingleImage', '
  query scrapeSingleImage($source: ScraperSourceInput! $input: ScrapeSingleImageInput!) { scrapeSingleImage(source: $source input: $input) { ...ScrapedImage } }
  fragment ScrapedImage on ScrapedImage { ScrapedImage_title: title ScrapedImage_code: code ScrapedImage_details: details ScrapedImage_photographer: photographer ScrapedImage_urls: urls ScrapedImage_date: date studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['source']] <- source
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSingleImage, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeURL
#' @description Scrapes content based on a URL
#' @param url   See the Playground for further details.
#' @param ty   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeURL <- function(url = list(), ty = NA, ...) {

  query <- ghql::Query$new()
  query$query('scrapeURL', '
  query scrapeURL($url: String! $ty: ScrapeContentType!) { scrapeURL(url: $url ty: $ty) { ...ScrapedContent } }
  fragment ScrapedContent on ScrapedContent { ...ScrapedStudio ...ScrapedTag ...ScrapedScene ...ScrapedGallery ...ScrapedImage ...ScrapedMovie ...ScrapedGroup ...ScrapedPerformer }
  fragment ScrapedStudio on ScrapedStudio { ScrapedStudio_stored_id: stored_id ScrapedStudio_name: name ScrapedStudio_urls: urls parent { stored_id name } ScrapedStudio_details: details ScrapedStudio_aliases: aliases tags { ...ScrapedTag } ScrapedStudio_remote_site_id: remote_site_id }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedScene on ScrapedScene { ScrapedScene_title: title ScrapedScene_code: code ScrapedScene_details: details ScrapedScene_director: director ScrapedScene_urls: urls ScrapedScene_date: date file { ...SceneFileType } studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } ScrapedScene_remote_site_id: remote_site_id ScrapedScene_duration: duration fingerprints { ...StashBoxFingerprint } }
  fragment ScrapedGallery on ScrapedGallery { ScrapedGallery_title: title ScrapedGallery_code: code ScrapedGallery_details: details ScrapedGallery_photographer: photographer ScrapedGallery_urls: urls ScrapedGallery_date: date studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } }
  fragment ScrapedImage on ScrapedImage { ScrapedImage_title: title ScrapedImage_code: code ScrapedImage_details: details ScrapedImage_photographer: photographer ScrapedImage_urls: urls ScrapedImage_date: date studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } }
  fragment ScrapedMovie on ScrapedMovie { ScrapedMovie_stored_id: stored_id ScrapedMovie_name: name ScrapedMovie_aliases: aliases ScrapedMovie_duration: duration ScrapedMovie_date: date ScrapedMovie_rating: rating ScrapedMovie_director: director ScrapedMovie_urls: urls ScrapedMovie_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedMovie_front_image: front_image ScrapedMovie_back_image: back_image }
  fragment ScrapedGroup on ScrapedGroup { ScrapedGroup_stored_id: stored_id ScrapedGroup_name: name ScrapedGroup_aliases: aliases ScrapedGroup_duration: duration ScrapedGroup_date: date ScrapedGroup_rating: rating ScrapedGroup_director: director ScrapedGroup_urls: urls ScrapedGroup_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedGroup_front_image: front_image ScrapedGroup_back_image: back_image }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
  fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
  ')

  variables <- list()
  variables[['url']] <- url
  variables[['ty']] <- ty

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeURL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapePerformerURL
#' @description Scrapes a complete performer record based on a URL
#' @param url   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapePerformerURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapePerformerURL', '
  query scrapePerformerURL($url: String!) { scrapePerformerURL(url: $url) { ...ScrapedPerformer } }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['url']] <- url

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapePerformerURL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeSceneURL
#' @description Scrapes a complete scene record based on a URL
#' @param url   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeSceneURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeSceneURL', '
  query scrapeSceneURL($url: String!) { scrapeSceneURL(url: $url) { ...ScrapedScene } }
  fragment ScrapedScene on ScrapedScene { ScrapedScene_title: title ScrapedScene_code: code ScrapedScene_details: details ScrapedScene_director: director ScrapedScene_urls: urls ScrapedScene_date: date file { ...SceneFileType } studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } groups { ...ScrapedGroup } ScrapedScene_remote_site_id: remote_site_id ScrapedScene_duration: duration fingerprints { ...StashBoxFingerprint } }
  fragment SceneFileType on SceneFileType { size duration video_codec audio_codec width height framerate bitrate }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  fragment ScrapedGroup on ScrapedGroup { ScrapedGroup_stored_id: stored_id ScrapedGroup_name: name ScrapedGroup_aliases: aliases ScrapedGroup_duration: duration ScrapedGroup_date: date ScrapedGroup_rating: rating ScrapedGroup_director: director ScrapedGroup_urls: urls ScrapedGroup_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedGroup_front_image: front_image ScrapedGroup_back_image: back_image }
  fragment StashBoxFingerprint on StashBoxFingerprint { algorithm hash duration }
  ')

  variables <- list()
  variables[['url']] <- url

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeSceneURL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeGalleryURL
#' @description Scrapes a complete gallery record based on a URL
#' @param url   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeGalleryURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeGalleryURL', '
  query scrapeGalleryURL($url: String!) { scrapeGalleryURL(url: $url) { ...ScrapedGallery } }
  fragment ScrapedGallery on ScrapedGallery { ScrapedGallery_title: title ScrapedGallery_code: code ScrapedGallery_details: details ScrapedGallery_photographer: photographer ScrapedGallery_urls: urls ScrapedGallery_date: date studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['url']] <- url

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeGalleryURL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeImageURL
#' @description Scrapes a complete image record based on a URL
#' @param url   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeImageURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeImageURL', '
  query scrapeImageURL($url: String!) { scrapeImageURL(url: $url) { ...ScrapedImage } }
  fragment ScrapedImage on ScrapedImage { ScrapedImage_title: title ScrapedImage_code: code ScrapedImage_details: details ScrapedImage_photographer: photographer ScrapedImage_urls: urls ScrapedImage_date: date studio { stored_id name } tags { ...ScrapedTag } performers { ...ScrapedPerformer } }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  fragment ScrapedPerformer on ScrapedPerformer { ScrapedPerformer_stored_id: stored_id ScrapedPerformer_name: name ScrapedPerformer_disambiguation: disambiguation ScrapedPerformer_gender: gender ScrapedPerformer_urls: urls ScrapedPerformer_birthdate: birthdate ScrapedPerformer_ethnicity: ethnicity ScrapedPerformer_country: country ScrapedPerformer_eye_color: eye_color ScrapedPerformer_height: height ScrapedPerformer_measurements: measurements ScrapedPerformer_fake_tits: fake_tits ScrapedPerformer_penis_length: penis_length ScrapedPerformer_circumcised: circumcised ScrapedPerformer_career_start: career_start ScrapedPerformer_career_end: career_end ScrapedPerformer_tattoos: tattoos ScrapedPerformer_piercings: piercings ScrapedPerformer_aliases: aliases tags { ...ScrapedTag } ScrapedPerformer_images: images ScrapedPerformer_details: details ScrapedPerformer_death_date: death_date ScrapedPerformer_hair_color: hair_color ScrapedPerformer_weight: weight ScrapedPerformer_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['url']] <- url

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeImageURL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: scrapeGroupURL
#' @description Scrapes a complete group record based on a URL
#' @param url   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
scrapeGroupURL <- function(url = list(), ...) {

  query <- ghql::Query$new()
  query$query('scrapeGroupURL', '
  query scrapeGroupURL($url: String!) { scrapeGroupURL(url: $url) { ...ScrapedGroup } }
  fragment ScrapedGroup on ScrapedGroup { ScrapedGroup_stored_id: stored_id ScrapedGroup_name: name ScrapedGroup_aliases: aliases ScrapedGroup_duration: duration ScrapedGroup_date: date ScrapedGroup_rating: rating ScrapedGroup_director: director ScrapedGroup_urls: urls ScrapedGroup_synopsis: synopsis studio { stored_id name } tags { ...ScrapedTag } ScrapedGroup_front_image: front_image ScrapedGroup_back_image: back_image }
  fragment ScrapedTag on ScrapedTag { ScrapedTag_stored_id: stored_id ScrapedTag_name: name ScrapedTag_description: description ScrapedTag_alias_list: alias_list parent { ...ScrapedTag } ScrapedTag_remote_site_id: remote_site_id }
  ')

  variables <- list()
  variables[['url']] <- url

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$scrapeGroupURL, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: plugins
#' @description List loaded plugins
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
plugins <- function(...) {

  query <- ghql::Query$new()
  query$query('plugins', '
  query plugins { plugins { ...Plugin } }
  fragment Plugin on Plugin { id name description url version enabled tasks { ...PluginTask } hooks { ...PluginHook } settings { ...PluginSetting } requires paths { ...PluginPaths } }
  fragment PluginTask on PluginTask { name description plugin { ...Plugin } }
  fragment PluginHook on PluginHook { name description hooks plugin { ...Plugin } }
  fragment PluginSetting on PluginSetting { name display_name description type }
  fragment PluginPaths on PluginPaths { javascript css }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$plugins, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: pluginTasks
#' @description List available plugin operations
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
pluginTasks <- function(...) {

  query <- ghql::Query$new()
  query$query('pluginTasks', '
  query pluginTasks { pluginTasks { ...PluginTask } }
  fragment PluginTask on PluginTask { name description plugin { ...Plugin } }
  fragment Plugin on Plugin { id name description url version enabled tasks { ...PluginTask } hooks { ...PluginHook } settings { ...PluginSetting } requires paths { ...PluginPaths } }
  fragment PluginHook on PluginHook { name description hooks plugin { ...Plugin } }
  fragment PluginSetting on PluginSetting { name display_name description type }
  fragment PluginPaths on PluginPaths { javascript css }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$pluginTasks, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: installedPackages
#' @description List installed packages
#' @param type   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
installedPackages <- function(type = NA, ...) {

  query <- ghql::Query$new()
  query$query('installedPackages', '
  query installedPackages($type: PackageType!) { installedPackages(type: $type) { ...Package } }
  fragment Package on Package { package_id name version date requires { ...Package } sourceURL source_package { ...Package } metadata }
  ')

  variables <- list()
  variables[['type']] <- type

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$installedPackages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: availablePackages
#' @description List available packages
#' @param type   See the Playground for further details.
#' @param source   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
availablePackages <- function(type = NA, source = list(), ...) {

  query <- ghql::Query$new()
  query$query('availablePackages', '
  query availablePackages($type: PackageType! $source: String!) { availablePackages(type: $type source: $source) { ...Package } }
  fragment Package on Package { package_id name version date requires { ...Package } sourceURL source_package { ...Package } metadata }
  ')

  variables <- list()
  variables[['type']] <- type
  variables[['source']] <- source

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$availablePackages, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: configuration
#' @description Returns the current, complete configuration
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
configuration <- function(...) {

  query <- ghql::Query$new()
  query$query('configuration', '
  query configuration { configuration { ...ConfigResult } }
  fragment ConfigResult on ConfigResult { general { ...ConfigGeneralResult } interface { ...ConfigInterfaceResult } dlna { ...ConfigDLNAResult } scraping { ...ConfigScrapingResult } defaults { ...ConfigDefaultSettingsResult } ui plugins }
  fragment ConfigGeneralResult on ConfigGeneralResult { stashes { ...StashConfig } databasePath backupDirectoryPath deleteTrashPath generatedPath metadataPath configFilePath scrapersPath pluginsPath cachePath blobsPath blobsStorage ffmpegPath ffprobePath calculateMD5 videoFileNamingAlgorithm parallelTasks previewAudio previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset transcodeHardwareAcceleration maxTranscodeSize maxStreamingTranscodeSize transcodeInputArgs transcodeOutputArgs liveTranscodeInputArgs liveTranscodeOutputArgs drawFunscriptHeatmapRange writeImageThumbnails createImageClipsFromVideos apiKey username password maxSessionAge logFile logOut logLevel logAccess logFileMaxSize useCustomSpriteInterval spriteInterval minimumSprites maximumSprites spriteScreenshotSize videoExtensions imageExtensions galleryExtensions createGalleriesFromFolders galleryCoverRegex excludes imageExcludes customPerformerImageLocation stashBoxes { ...StashBox } pythonPath scraperPackageSources { ...PackageSource } pluginPackageSources { ...PackageSource } }
  fragment ConfigInterfaceResult on ConfigInterfaceResult { sfwContentMode menuItems soundOnPreview wallShowTitle wallPlayback showScrubber maximumLoopDuration noBrowser notificationsEnabled autostartVideo autostartVideoOnPlaySelected continuePlaylistDefault showStudioAsText css cssEnabled javascript javascriptEnabled customLocales customLocalesEnabled disableCustomizations language imageLightbox { ...ConfigImageLightboxResult } disableDropdownCreate { ...ConfigDisableDropdownCreate } handyKey funscriptOffset useStashHostedFunscript }
  fragment ConfigDLNAResult on ConfigDLNAResult { serverName enabled port whitelistedIPs interfaces videoSortOrder }
  fragment ConfigScrapingResult on ConfigScrapingResult { scraperUserAgent scraperCDPPath scraperCertCheck excludeTagPatterns }
  fragment ConfigDefaultSettingsResult on ConfigDefaultSettingsResult { scan { ...ScanMetadataOptions } identify { ...IdentifyMetadataTaskOptions } autoTag { ...AutoTagMetadataOptions } generate { ...GenerateMetadataOptions } deleteFile deleteGenerated }
  fragment StashConfig on StashConfig { path excludeVideo excludeImage }
  fragment StashBox on StashBox { endpoint api_key name max_requests_per_minute }
  fragment PackageSource on PackageSource { name url local_path }
  fragment ConfigImageLightboxResult on ConfigImageLightboxResult { slideshowDelay displayMode scaleUp resetZoomOnNav scrollMode scrollAttemptsBeforeChange disableAnimation }
  fragment ConfigDisableDropdownCreate on ConfigDisableDropdownCreate { performer tag studio movie gallery }
  fragment ScanMetadataOptions on ScanMetadataOptions { rescan scanGenerateCovers scanGeneratePreviews scanGenerateImagePreviews scanGenerateSprites scanGeneratePhashes scanGenerateImagePhashes scanGenerateThumbnails scanGenerateClipPreviews }
  fragment IdentifyMetadataTaskOptions on IdentifyMetadataTaskOptions { sources { ...IdentifySource } options { ...IdentifyMetadataOptions } }
  fragment AutoTagMetadataOptions on AutoTagMetadataOptions { performers studios tags }
  fragment GenerateMetadataOptions on GenerateMetadataOptions { covers sprites previews imagePreviews previewOptions { ...GeneratePreviewOptions } markers markerImagePreviews markerScreenshots transcodes phashes interactiveHeatmapsSpeeds imageThumbnails clipPreviews }
  fragment IdentifySource on IdentifySource { source { ...ScraperSource } options { ...IdentifyMetadataOptions } }
  fragment IdentifyMetadataOptions on IdentifyMetadataOptions { fieldOptions { ...IdentifyFieldOptions } setCoverImage setOrganized performerGenders skipMultipleMatches skipMultipleMatchTag skipSingleNamePerformers skipSingleNamePerformerTag }
  fragment ScraperSource on ScraperSource { stash_box_endpoint scraper_id }
  fragment IdentifyFieldOptions on IdentifyFieldOptions { field strategy createMissing }
  fragment GeneratePreviewOptions on GeneratePreviewOptions { previewSegments previewSegmentDuration previewExcludeStart previewExcludeEnd previewPreset }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$configuration, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: directory
#' @description Returns an array of paths for the given path
#' @param path   The directory path to list
#' @param locale   Desired collation locale. Determines the order of the directory result. eg. 'en-US', 'pt-BR', ...
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
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
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$directory, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: validateStashBoxCredentials
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
validateStashBoxCredentials <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('validateStashBoxCredentials', '
  query validateStashBoxCredentials($input: StashBoxInput!) { validateStashBoxCredentials(input: $input) { ...StashBoxValidationResult } }
  fragment StashBoxValidationResult on StashBoxValidationResult { valid status }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$validateStashBoxCredentials, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: systemStatus
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
systemStatus <- function(...) {

  query <- ghql::Query$new()
  query$query('systemStatus', '
  query systemStatus { systemStatus { ...SystemStatus } }
  fragment SystemStatus on SystemStatus { databaseSchema databasePath configPath appSchema status os workingDir homeDir ffmpegPath ffprobePath }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$systemStatus, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: jobQueue
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
jobQueue <- function(...) {

  query <- ghql::Query$new()
  query$query('jobQueue', '
  query jobQueue { jobQueue { ...Job } }
  fragment Job on Job { id status subTasks description progress startTime endTime addTime error }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$jobQueue, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: findJob
#' 
#' @param input   See the Playground for further details.
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
findJob <- function(input = NA, ...) {

  query <- ghql::Query$new()
  query$query('findJob', '
  query findJob($input: FindJobInput!) { findJob(input: $input) { ...Job } }
  fragment Job on Job { id status subTasks description progress startTime endTime addTime error }
  ')

  variables <- list()
  variables[['input']] <- input

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$findJob, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: dlnaStatus
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
dlnaStatus <- function(...) {

  query <- ghql::Query$new()
  query$query('dlnaStatus', '
  query dlnaStatus { dlnaStatus { ...DLNAStatus } }
  fragment DLNAStatus on DLNAStatus { running until recentIPAddresses allowedIPAddresses { ...DLNAIP } }
  fragment DLNAIP on DLNAIP { ipAddress until }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$dlnaStatus, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: allPerformers
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
allPerformers <- function(...) {

  query <- ghql::Query$new()
  query$query('allPerformers', '
  query allPerformers { allPerformers { ...Performer } }
  fragment Performer on Performer { id name disambiguation urls gender birthdate ethnicity country eye_color height_cm measurements fake_tits penis_length circumcised career_start career_end tattoos piercings alias_list favorite tags { id name } ignore_auto_tag image_path scene_count image_count gallery_count group_count performer_count o_counter scenes { id title } stash_ids { endpoint stash_id } rating100 details death_date hair_color weight created_at updated_at groups { id name } custom_fields }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$allPerformers, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: version
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
version <- function(...) {

  query <- ghql::Query$new()
  query$query('version', '
  query version { version { ...Version } }
  fragment Version on Version { version hash build_time }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$version, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

#' Call GraphQL operation: latestversion
#' 
#' @param ... additional parameters like .field to retrieve only a certain field from the response
#' @importFrom ghql Query
#' @return processed API response
#' @export
latestversion <- function(...) {

  query <- ghql::Query$new()
  query$query('latestversion', '
  query latestversion { latestversion { ...LatestVersion } }
  fragment LatestVersion on LatestVersion { version shorthash release_date url }
  ')

  variables <- list()

  return_default <- NA_character_
  dotargs <- list(...)
  if(!".field" %in% names(dotargs)) {
    dotargs$.field <- return_default
  }
  res <- executeQuery(query = query$queries$latestversion, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

  return(res)
}

