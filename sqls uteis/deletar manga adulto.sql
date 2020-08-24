	
    CREATE TEMPORARY TABLE manga_adult (id int unsigned, PRIMARY KEY (`id`)); 

    insert into manga_adult
    select distinct m.id from manga m 
	join manga_categories mc on mc.manga_id = m.id
	join category c on c.id = mc.category_id
	where c.adult = 1;
    
    select count(1) as 'qtd_manga_adult' from manga_adult;

	delete p
	from page p
	join chapter cha on cha.id = p.chapter_id
	join manga m on m.id = cha.manga_id
	join manga_adult ma_adult on ma_adult.id = m.id;
    
	select 'page deleted';

    -- 2, 12, 21, 22, 56, 57
	-- c.adult = 1;

	delete cha_read
	from chapter_read cha_read
    join chapter cha on cha.id = cha_read.chapter_id
	join manga m on m.id = cha.manga_id
	join manga_adult ma_adult on ma_adult.id = m.id;

	delete cha
	from chapter cha
	join manga m on m.id = cha.manga_id
	join manga_adult ma_adult on ma_adult.id = m.id;
    
    select 'chapter deleted';

	delete ma
	from manga_author ma
	join manga_adult ma_adult on ma_adult.id = ma.manga_id;
    
    select 'manga author deleted';

	delete ma
	from manga_artist ma
	join manga_adult ma_adult on ma_adult.id = ma.manga_id;
    
    select 'manga artist deleted';

	delete mc
	from manga_categories mc
	join manga_adult ma_adult on ma_adult.id = mc.manga_id;
    
    select 'manga categories deleted';

	delete m_follow
    from following_manga m_follow
	join manga m on m.id = m_follow.manga_id
	join manga_adult ma_adult on ma_adult.id = m.id;

	delete m
	from manga m 
	join manga_adult ma_adult on ma_adult.id = m.id;
    
    select 'manga_deleted';
    
	DROP TABLE manga_adult; 