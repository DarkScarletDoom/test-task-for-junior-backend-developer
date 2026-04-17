-- Удаляем возможные дубликаты (если есть)
DELETE FROM tasks t1 USING tasks t2
WHERE t1.parent_rule_id = t2.parent_rule_id 
  AND t1.scheduled_at = t2.scheduled_at 
  AND t1.id > t2.id;

-- Создаём уникальный индекс
CREATE UNIQUE INDEX CONCURRENTLY IF NOT EXISTS idx_unique_task_per_date 
ON tasks (parent_rule_id, scheduled_at) 
WHERE parent_rule_id IS NOT NULL;