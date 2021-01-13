




### {{ $entity_info['display_name'] }}列表
----
```
GET /{{ english_word_pluralize($entity_name) }} 
```
##### 参数
@foreach ($entity_info['structs'] as $struct_name => $struct)
- {{ $struct_name }}:  
    可选参数，通过{{ $struct['display_name'] }}筛选

@endforeach
@foreach ($relationship_infos['relationships'] as $attribute_name => $relationship)
@if ($relationship['relationship_type'] === 'belongs_to')
- {{ $attribute_name.'_id' }}:  
    通过关联关系 `{{ $attribute_name.'_id' }}` 筛选

@endif
@foreach ($relationship['snaps'] as $structs)
@foreach ($structs as $struct_name => $struct)
- {{ $struct_name }}:  
    通过关联关系冗余{{ $struct['display_name'] }}筛选
@endforeach
@endforeach
@endforeach
##### 返回值
```php
return [
    'code' => 0,
    'msg'  => '',
    'count' => 0, // 查询出来的{{ $entity_info['display_name'] }}数量
    'data' => [], // 查询出来的{{ $entity_info['display_name'] }}数组
];
```
{{ $entity_info['display_name'] }}数组包含多个{{ $entity_info['display_name'] }}结构，单个结构的格式为
```php
[
    'id' => 0, // 主键
@foreach ($entity_info['structs'] as $struct_name => $struct)
    {{ blade_eval(_generate_docs_api_data_type_list($struct['data_type']), ['entity_name' => $entity_name, 'struct_name' => $struct_name, 'struct' => $struct]) }} 
@endforeach
@foreach ($relationship_infos['relationships'] as $attribute_name => $relationship)
@if ($relationship['relationship_type'] === 'belongs_to')
    '{{ $attribute_name }}_display' => '', // 关联关系 `{{ $attribute_name }}` 的文字化展示
@foreach ($relationship['snaps'] as $structs)
@foreach ($structs as $struct_name => $struct)
    {{ blade_eval(_generate_docs_api_data_type_list($struct['data_type']), ['entity_name' => $entity_name, 'struct_name' => $struct_name, 'struct' => $struct]) }}, 冗余自 `{{ $attribute_name }}` {{ $relationship['entity_display_name'] }}的 `{{ $struct['target_struct_name'] }}` 属性
@endforeach
@endforeach
@endif
@endforeach
    'create_time' => {{ datetime() }}, // 创建时间
    'update_time' => {{ datetime() }}, // 最后一次修改时间
]
```



