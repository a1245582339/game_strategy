import React, { useState } from 'react';
import { Modal, Form, Input, Select, Spin, Upload, Icon, Button, message } from 'antd';
import { FormComponentProps } from "antd/es/form";
import { createArticleApi } from '@/api/article';
import { UploadFile, UploadChangeParam } from 'antd/lib/upload/interface';
import { getGameApi } from '@/api/game';
import { Editor } from 'react-draft-wysiwyg';
import { EditorState, convertToRaw } from 'draft-js';
import 'react-draft-wysiwyg/dist/react-draft-wysiwyg.css';
import http from '@/api/config'
import draftToHtml from 'draftjs-to-html';

const { Option } = Select;
interface IFormProps extends FormComponentProps {
    visible: boolean
    fetchData(): void
    onClose(): void
}
interface IGame {
    id: number
    name: string
}

const CreateDialog: React.FC<IFormProps> = props => {
    const [coverPath, setCoverPath] = useState<UploadFile[]>([])
    const [searchLoading, setSearchLoading] = useState(false)
    const [gameList, setGameList] = useState<IGame[]>([])
    const [content, setContent] = useState<EditorState>(EditorState.createEmpty())
    const { getFieldDecorator } = props.form
    const handleOk = () => {
        props.form.validateFields(async (err, value) => {
            if (!err) {
                const data = { ...value, content: draftToHtml(convertToRaw(content.getCurrentContent())), cover: value.cover ? value.cover.file.response.path : '' }
                await createArticleApi(data)
                message.success('创建成功')
                props.onClose()
                props.fetchData()
            }
        })
    }
    const handleSearch = async (value: string) => {
        if (value) {
            setSearchLoading(true)
            const result = await getGameApi<{ list: IGame[] }>({ name: value, page: 0, size: 20 })
            setGameList(result.list.map(item => ({ id: item.id, name: item.name })))
            setTimeout(() => {
                setSearchLoading(false)
            }, 300)
        } else {
            setGameList([])
        }

    }
    const handleCancel = () => {
        setContent(EditorState.createEmpty())
        props.onClose()
    }
    const handleUpload = (info: UploadChangeParam) => {
        setCoverPath([info.fileList[info.fileList.length - 1]])
    }
    const handlePreview = (file: UploadFile) => {
        window.open(file.response.path)
    }
    return (
        <Modal
            style={{ top: 20 }}
            width={1200}
            title="新建文章"
            visible={props.visible}
            onOk={handleOk}
            onCancel={handleCancel}
            destroyOnClose={true}
        >
            <Form layout="vertical">
                <Form.Item label="标题">
                    {getFieldDecorator('title', {
                        rules: [{ required: true, message: '请输入名称！' }],
                        initialValue: ''
                    })(<Input />)}
                </Form.Item>
                <Form.Item label="游戏">
                    {getFieldDecorator('gameId', {
                        rules: [{ required: true, message: '请选择游戏！' }],
                    })(<Select
                        style={{ width: 300, marginLeft: 10 }}
                        showSearch
                        allowClear
                        placeholder="请搜索游戏名称选择游戏"
                        onSearch={handleSearch}
                        filterOption={false}
                        notFoundContent={searchLoading ? <Spin size="small" /> : null}
                    >
                        {gameList.map((item: IGame) => <Option key={item.id}>{item.name}</Option>)}
                    </Select>)}
                </Form.Item>
                <Form.Item label="封面">
                    {getFieldDecorator('cover', {
                    })(<Upload
                        name='file'
                        accept="image/*"
                        action='/api/v1/upload'
                        fileList={coverPath}
                        onChange={handleUpload}
                        listType='picture'
                        onPreview={handlePreview}
                    >
                        <Button>
                            <Icon type="upload" />点击上传封面
                        </Button>
                    </Upload>)}

                </Form.Item>
                <Form.Item label="内容">
                    {getFieldDecorator('content', {
                        initialValue: ''
                    })(<div style={{ border: '1px solid #ddd' }}><Editor
                        editorState={content}
                        onEditorStateChange={(value: EditorState) => {
                            setContent(value)
                        }}
                        localization={{
                            locale: 'zh'
                        }}
                        toolbar={{
                            image: {
                                urlEnabled: false,
                                defaultSize: {
                                    height: 'auto',
                                    width: '100%',
                                  },
                                uploadCallback: async (img: File) => {
                                    var data = new FormData()
                                    data.append('file', img)
                                    const res: any = await http.post('/upload', data)
                                    return { data: { link: res.path } }
                                }
                            }
                        }}
                    /></div>)}
                </Form.Item>
            </Form>
        </Modal>
    )
}
export default Form.create<IFormProps>()(CreateDialog)