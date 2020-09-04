delete c
from chapter c
left join page p on p.chapter_id = c.id
left join chapter_read cr on cr.chapter_id = c.id
where p.id is null and cr.chapter_id is null;