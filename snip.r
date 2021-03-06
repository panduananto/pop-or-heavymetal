library(spotifyr)
library(dplyr)
library(data.table)

Sys.setenv(SPOTIFY_CLIENT_ID = '80d70050fc2d449dbb7e8d488f1c8436')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'e97f0025874b45dfafbcfbc868ef400d')

access_token <- get_spotify_access_token()

playlist_pop <- list()
pop_audio_feature <- data.frame()

for (i in 1:5) {
  # ambil lagu dengan genre pop
  pop <- get_recommendations(limit = 50, seed_genres = "pop")
  # ambil audio feature lagu berdasarkan id lagu
  pop_audio_feature <- lapply(pop$id, 
                              function(x){get_track_audio_features(x)})
  # tampung data hasil iterasi
  playlist_pop <- rbind(playlist_pop,
                        pop_audio_feature)
}

# konversi list ke dataframe
raw_data_pop <- rbindlist(playlist_pop)
# tambahkan kolom genre dengna nilai pop
raw_data_pop$genre <- "pop"

playlist_heavy_metal <- list()
heavy_metal_audio_feature <- data.frame()

for (i in 1:5) {
  # ambil lagu dengan genre heavy-metal
  heavy_metal <- get_recommendations(limit = 50, seed_genres = "heavy-metal")
  # ambil audio feature lagu berdasarkan id lagu
  heavy_metal_audio_feature <- lapply(heavy_metal$id,
                                      function(x){get_track_audio_features(x)})
  # tampung data hasil iterasi
  playlist_heavy_metal <- rbind(playlist_heavy_metal,
                                heavy_metal_audio_feature)
}

# konversi list ke dataframe
raw_data_heavy_metal <- rbindlist(playlist_heavy_metal)
# tambahkan kolom genre dengna nilai heavy-metal
raw_data_heavy_metal$genre <- "heavy-metal"

raw_data <- rbindlist(list(raw_data_pop, raw_data_heavy_metal))
write.csv(raw_data, "masterplaylist.csv")