import React, { useState, useEffect } from 'react';
import { Modal, Form, Input, Select, Spin, Upload, Icon, Button } from 'antd';
import { FormComponentProps } from "antd/es/form";
import { getArticleDetailApi, createArticleApi } from '@/api/article';
import { ContentUtils } from 'braft-utils'
import { getGameApi } from '@/api/game';
import BraftEditor from 'braft-editor'
import 'braft-editor/dist/index.css'

const { Option } = Select;
interface IFormProps extends FormComponentProps {
    visible: boolean
    onClose(): void
}
interface IGame {
    id: number
    name: string
}

const CreateDialog: React.FC<IFormProps> = props => {
    const [gameId, setGameId] = useState(0)
    const [searchLoading, setSearchLoading] = useState(false)
    const [gameList, setGameList] = useState<IGame[]>([])
    const [content, setContent] = useState(BraftEditor.createEditorState(null))
    const { getFieldDecorator } = props.form
    const handleOk = () => {
        props.form.validateFields(async (err, value) => {
            if (!err) {
                
            }
        })
    }
    const handleSearch = async (value: string) => {
        if (value) {
            setSearchLoading(true)
            const result = await getGameApi<{ list: IGame[] }>({ name: value, page: 0, size: 20 })
            setGameList(result.list.map(item => ({id: item.id, name: item.name})))
            setTimeout(() => {
                setSearchLoading(false)
            }, 300)
        } else {
            setGameList([])
        }
        
    }
    const handleEditorChange = (editorState: any) => {
        setContent(editorState)
    }
    const handleCancel = () => {
        props.onClose()
    }
    return (
        <Modal
            width={1200}
            title="新建文章"
            visible={props.visible}
            onOk={handleOk}
            onCancel={handleCancel}
            destroyOnClose={true}
        >
            <Form layout="vertical">
                <Form.Item label="名称">
                    {getFieldDecorator('name', {
                        rules: [{ required: true, message: '请输入名称！' }],
                    })(<Input />)}
                </Form.Item>
                <Form.Item label="游戏">
                    {getFieldDecorator('gameId', {
                        rules: [{ required: true, message: '请选择游戏！' }],
                    })(<Select
                        style={{width: 300, marginLeft: 10}}
                        showSearch
                        allowClear
                        placeholder="请搜索游戏名称选择游戏"
                        onSearch={handleSearch}
                        filterOption={false}
                        notFoundContent={searchLoading ? <Spin size="small" /> : null}
                        onChange={(value: number) => { setGameId(value) }}
                    >
                        {gameList.map((item: IGame) => <Option key={item.id}>{item.name}</Option>)}
                    </Select>)}
                </Form.Item>
                <Form.Item label="名称">
                    {getFieldDecorator('name', {
                        rules: [{ required: true, message: '请输入名称！' }],
                        initialValue: content
                    })(<BraftEditor
                        onChange={handleEditorChange}
                        extendControls={[
                            {
                              key: 'antd-uploader',
                              type: 'component',
                              component: (
                                <Upload
                                  accept="image/*"
                                  showUploadList={false}
                                  action='/api/v1/upload'
                                  onChange={() => {
                                      setContent(ContentUtils.insertMedias(content, [{
                                        type: 'IMAGE',
                                        url: URL.createObjectURL
                                      }]))
                                  }}
                                >
                                  {/* 这里的按钮最好加上type="button"，以避免在表单容器中触发表单提交，用Antd的Button组件则无需如此 */}
                                  <Button>
                                    插入图片
                                    <Icon type="picture" theme="filled" />
                                  </Button>
                                </Upload>
                              )
                            }
                          ]}
                    />)}
                </Form.Item>
            </Form>
        </Modal>
    )
}
export default Form.create<IFormProps>()(CreateDialog)