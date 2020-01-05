import React, { useState, useEffect, useCallback } from 'react';
import { Modal, Spin } from 'antd';
import { getArticleDetailApi } from '@/api/article';

interface IProps {
    visible: boolean
    id?: number
    onClose(): void
}
interface IArticle {
    id: number
    title: string
    cover: string
    game: {
        name: string
    }
    content: string
    create_time: string
}

const PreviewDialog: React.FC<IProps> = (props) => {
    const [detail, setDetail] = useState<IArticle>()
    const [loading, setLoading] = useState(false)
    const getDetail = useCallback(async () => {
        if (props.id) {
            setLoading(true)
            const result = await getArticleDetailApi<{ msg: string; detail: IArticle }>(props.id)
            setDetail(result.detail)
            setTimeout(() => {
                setLoading(false)
            }, 300)
        }
    }, [props.id])
    useEffect(() => {
        getDetail()
    }, [getDetail])
    return (
        <Modal
            title={detail?.title || ''}

            visible={props.visible}
        >
            {(detail?.content && !loading) ?
                <div dangerouslySetInnerHTML={{__html: detail?.content}}></div> :
                <Spin size="small" />
            }
        </Modal>
    )
}
export default PreviewDialog