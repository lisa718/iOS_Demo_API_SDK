<?php
    /** 二进制流生成文件
     * $_POST 无法解释二进制流，需要用到 $GLOBALS['HTTP_RAW_POST_DATA'] 或 php://input
     * $GLOBALS['HTTP_RAW_POST_DATA'] 和 php://input 都不能用于 enctype=multipart/form-data
     * @param    String  $file   要生成的文件路径
     * @return   boolean
     */
    function binary_to_file($file){
        $content = $GLOBALS['HTTP_RAW_POST_DATA'];          // 需要php.ini设置
        if(empty($content)){
            $content = file_get_contents('php://input');    // 不需要php.ini设置，内存压力小
        }
        $ret = file_put_contents($file, $content, true);
        return $ret;
    }
    $file_dir="images/image.png";  // 固定的文件名,注意设置images文件夹权限为所有用户可读写！！！
    binary_to_file($file_dir);
?>