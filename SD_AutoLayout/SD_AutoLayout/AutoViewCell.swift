//
//  AutoViewCell.swift
//  SD_AutoLayout
//
//  Created by mac on 17/9/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class AutoViewCell: UITableViewCell {

    var view1: UIView?
    var view2: UIView?
    var view3: UILabel?
    var view4: UIView?
    var view5: UIView?
    var view6: UIView?
    
    var imgView: UIImageView?
    
    var model: itemModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initChildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initChildViews(){
        view1 = UIView()
        view1?.backgroundColor = UIColor.red
        view2 = UIView()
        view2?.backgroundColor = UIColor.green
        view3 = UILabel()
        view3?.backgroundColor = UIColor.blue
        view3?.textColor = UIColor.darkGray
        view3?.font = UIFont.systemFont(ofSize: 15)
        view3?.numberOfLines = 0;
//        view3?.text = "AAAAAAA"
        
        view4 = UIView()
        view4?.backgroundColor = UIColor.yellow
        view5 = UIView()
        view5?.backgroundColor = UIColor.cyan
        view6 = UIView()
        view6?.backgroundColor = UIColor.brown
        
        imgView = UIImageView()
        imgView?.backgroundColor = UIColor.orange
        
        contentView.addSubview(view1!)
        contentView.addSubview(view2!)
        contentView.addSubview(view3!)
        contentView.addSubview(view4!)
        contentView.addSubview(view5!)
        contentView.addSubview(view6!)
        
        contentView.addSubview(imgView!)
        
        //开始自动布局
        let margin: CGFloat = 10
        
        view1?.sd_layout()
        .topSpaceToView(contentView, margin)?
        .leftSpaceToView(contentView, margin)?
        .widthIs(50)?
            .heightIs(50);
        
        view2?.sd_layout()
        .topSpaceToView(contentView,margin)?
        .leftSpaceToView(view1,margin)?
        .rightSpaceToView(contentView,margin)?
        .heightRatioToView(view1, 0.4)
        
        view3?.sd_layout()
            .topSpaceToView(view2, margin)?
            .leftEqualToView(view2)?
//            .leftSpaceToView(view1, margin)?
            .rightSpaceToView(contentView,6*margin)?
            .autoHeightRatio(0)
//            .bottomSpaceToView(view4,margin)
        
        view4?.sd_layout()
            .topEqualToView(view3)?
            .leftSpaceToView(view3,margin)?
            .rightEqualToView(view2)?
            .heightRatioToView(view3,1)
        
        view5?.sd_layout()
            .topSpaceToView(view4,margin)?
            .leftEqualToView(view3)?
            .rightSpaceToView(contentView,8*margin)?
            .heightIs(30)
        
        view6?.sd_layout()
            .leftSpaceToView(view5,margin)?
            .topEqualToView(view5)?
            .rightEqualToView(view4)?
            .bottomEqualToView(view5)
        
//        _view3.sd_layout
//            .topSpaceToView(_view2, 10)
//            .leftEqualToView(_view2)
//            .widthRatioToView(_view2, 0.7);
        imgView?.sd_layout()
            .topSpaceToView(view5, margin)?.leftEqualToView(view5)?.widthRatioToView(view5,1)
        
        self.setupAutoHeight(withBottomView: imgView, bottomMargin: margin)
    }
    
    func setModel(model: itemModel){
        self.model = model
        
        view3?.text = model.content
        
        var bottomMargin: CGFloat = 0
        
        // 在实际的开发中，网络图片的宽高应由图片服务器返回然后计算宽高比。
        if model.imageName != "" {
            let img = UIImage(named: model.imageName!)
            if ((img?.size.width)! > CGFloat(0)) {
                let scale = (img?.size.height)! / (img?.size.width)!;
                imgView?.sd_layout().autoHeightRatio(scale);
                imgView?.image = img;
                bottomMargin = 10;
                //            _view4.hidden = YES;
            } else {
                imgView?.sd_layout().autoHeightRatio(0);
                //            _view4.hidden = NO;
            }
        }else{
            imgView?.sd_layout().autoHeightRatio(0);
        }
        
    }
}
