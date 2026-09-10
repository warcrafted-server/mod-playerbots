CREATE TABLE IF NOT EXISTS `playerbots_area_cache` (
  `map_id` SMALLINT(5) UNSIGNED NOT NULL,
  `pos_x` INT(11) NOT NULL,
  `pos_y` INT(11) NOT NULL,
  `pos_z` INT(11) NOT NULL,
  `area_id` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`map_id`,`pos_x`,`pos_y`,`pos_z`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Playerbots Area Id Cache';
