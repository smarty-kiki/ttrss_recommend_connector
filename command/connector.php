<?php

command('connector:run', '启动模拟同步演练', function ()
{/*{{{*/
    http_json([
        'url'    => 'http://tag.yao-yang.cn/goods/delete_keep_100',
        'method' => 'POST',
        'timeout' => 60,
    ]);

    $last_good_info = http_json('http://tag.yao-yang.cn/last_one_good_info');

    $last_id = 0;
    if (isset($last_good_info['data']['extend_id'])) {
        $last_id = $last_good_info['data']['extend_id'];
    }

    $rows = db_query(
        'select id, link, title, content_hash, content from ttrss_entries where id > :last_id order by date_entered desc limit 300',
        [':last_id' => $last_id]
    );

    foreach ($rows as $row) {
        $result_tags = baidu_ai_nlp_tag($row['title'], $row['content']);

        $good_info = http_json([
            'url' => 'http://tag.yao-yang.cn/goods/add',
            'data' => [
                'url'  => 'http://tag.yao-yang.cn/static/good_view.html?extend_id='.$row['id'],
                'name' => $row['title'],
                'content' => $row['content'],
                'extend_id' => $row['id'],
            ],
            'timeout' => 60,
        ]);

        foreach ($result_tags as $tag) {
            $result_tag_info = http_json([
                'url' => 'http://tag.yao-yang.cn/tags/add',
                'data' => [
                    'name' => $tag['tag'],
                    'type' => 'good',
                ],
                'timeout' => 60,
            ]);


            if (isset($result_tag_info['data']['id'])) {
                http_json([
                    'url' => 'http://tag.yao-yang.cn/tag_targets/add_to_good/'.$good_info['data']['id'],
                    'data' => [
                        'tag_id' => $result_tag_info['data']['id'],
                    ],
                    'timeout' => 60,
                ]);
            }
        }
    }

});/*}}}*/
